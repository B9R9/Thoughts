import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'screens/lock_screen.dart';
import 'screens/settings_page.dart';
import 'screens/onboarding_page.dart';
import 'screens/thought_page.dart';
import 'screens/pincode_screen.dart';

import 'widgets/thought_input.dart';
import 'widgets/wave_clipper.dart';

import 'models/thought.dart';
import 'services/hive_service.dart';

import 'l10n/strings.dart';

// ═══════════════════════════════════════════════════════════════
//  MAIN
// ═══════════════════════════════════════════════════════════════

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  runApp(const MyApp());
}

// ═══════════════════════════════════════════════════════════════
//  APP
// ═══════════════════════════════════════════════════════════════

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _secureStorage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HiveService.settings.listenable(),
      builder: (context, Box settingsBox, _) {
        final savedLang = settingsBox.get('language', defaultValue: 'en');
        final onboardingSeen = settingsBox.get(
          'onboarding_seen',
          defaultValue: false,
        );

        return MaterialApp(
          title: Strings.appTitle(savedLang),
          locale: Locale(savedLang),
          supportedLocales: const [
            Locale('en'), // English
            Locale('fr'), // French
            Locale('fi'), // Finnish
            Locale('sv'), // Swedish
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: _buildTheme(),
          home: onboardingSeen
              ? FutureBuilder<String?>(
                  future: _secureStorage.read(key: 'pin_code'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Scaffold(
                        backgroundColor: Color(0xFF121212),
                        body: Center(
                          child: CircularProgressIndicator(color: Colors.teal),
                        ),
                      );
                    }

                    final pinCode = snapshot.data;
                    if (pinCode == null || pinCode.isEmpty) {
                      return PinCodePage(
                        isSetup: true,
                        child: MyHomePage(title: Strings.appTitle(savedLang)),
                      );
                    }

                    return LockScreen(
                      child: MyHomePage(title: Strings.appTitle(savedLang)),
                    );
                  },
                )
              : OnboardingPage(
                  child: MyHomePage(title: Strings.appTitle(savedLang)),
                ),
        );
      },
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.teal,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.normal,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFF1E1E1E),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.teal,
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  HOME PAGE
// ═══════════════════════════════════════════════════════════════

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Controllers
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();
  final TextEditingController _textController = TextEditingController();
  late final ValueListenable _thoughtsListenable;

  // State
  ScrollController? _currentScrollController;
  Map<String, List<Thought>> _groupedThoughts = {};

  // ───────────────── LIFECYCLE ─────────────────

  @override
  void initState() {
    super.initState();
    _thoughtsListenable = HiveService.box.listenable();
    _initializeApp();
  }

  void _initializeApp() {
    _loadThoughts();
    _setupSheetListener();
    _thoughtsListenable.addListener(_refreshThoughts);
  }

  void _refreshThoughts() {
    _loadThoughts();
  }

  void _setupSheetListener() {
    _sheetController.addListener(() {
      if (_sheetController.size < 0.15) {
        _scrollToTop();
      }
    });
  }

  void _scrollToTop() {
    _currentScrollController?.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _thoughtsListenable.removeListener(_refreshThoughts);
    _textController.dispose();
    _sheetController.dispose();
    super.dispose();
  }

  // ───────────────── DATA ─────────────────

  Future<void> _loadThoughts() async {
    final thoughts = await HiveService.getThoughts();
    final grouped = _groupThoughtsByDate(thoughts);

    setState(() {
      _groupedThoughts = grouped;
    });
  }

  Map<String, List<Thought>> _groupThoughtsByDate(List<Thought> thoughts) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    final startOfLastWeek = startOfWeek.subtract(const Duration(days: 7));
    final startOfMonth = DateTime(now.year, now.month, 1);
    final startOfLastMonth = DateTime(now.year, now.month - 1, 1);
    final startOfMonthMinus2 = DateTime(now.year, now.month - 2, 1);

    final Map<String, List<Thought>> grouped = {
      'today': [],
      'this_week': [],
      'last_week': [],
      'this_month': [],
      'last_month': [],
      'two_months_ago': [],
      'older': [],
    };

    for (final thought in thoughts) {
      final date = thought.createdAt;
      if (date.isAfter(today) && date.isBefore(tomorrow)) {
        grouped['today']!.add(thought);
      } else if (date.isAfter(startOfWeek) && date.isBefore(today)) {
        grouped['this_week']!.add(thought);
      } else if (date.isAfter(startOfLastWeek) && date.isBefore(startOfWeek)) {
        grouped['last_week']!.add(thought);
      } else if (date.isAfter(startOfMonth) && date.isBefore(startOfWeek)) {
        grouped['this_month']!.add(thought);
      } else if (date.isAfter(startOfLastMonth) &&
          date.isBefore(startOfMonth)) {
        grouped['last_month']!.add(thought);
      } else if (date.isAfter(startOfMonthMinus2) &&
          date.isBefore(startOfLastMonth)) {
        grouped['two_months_ago']!.add(thought);
      } else {
        grouped['older']!.add(thought);
      }
    }

    for (final entry in grouped.entries) {
      entry.value.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }

    return grouped;
  }

  // ───────────────── ACTIONS ─────────────────

  Future<void> _saveThought() async {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    await HiveService.addThought(text);

    _textController.clear();
    await _loadThoughts();
  }

  void _toggleSheet() {
    if (!_sheetController.isAttached) return;

    final targetSize = _sheetController.size > 0.15 ? 0.15 : 0.5;
    _sheetController.animateTo(
      targetSize,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    _scrollToTop();
  }

  void _collapseSheet() {
    if (_sheetController.isAttached && _sheetController.size > 0.1) {
      _sheetController.animateTo(
        0.15,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _scrollToTop();
    }
  }

  Future<void> _deleteThought(String thoughtId) async {
    await HiveService.deleteThought(thoughtId);
    await _loadThoughts();
  }

  Future<void> _openThoughtDetails(Thought thought) async {
    final deleted = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => ThoughtPage(thought: thought)),
    );

    if (deleted == true) {
      await _loadThoughts();
    }
  }

  // ───────────────── BUILD ─────────────────

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HiveService.settings.listenable(),
      builder: (context, Box settingsBox, _) {
        final languageCode = settingsBox.get('language', defaultValue: 'en');
        final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
        final isSheetExpanded =
            _sheetController.isAttached && _sheetController.size > 0.1;

        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            onHorizontalDragEnd: isSheetExpanded ? null : _handleSwipeRight,
            behavior: HitTestBehavior.translucent,
            child: Stack(
              children: [
                // Background tap to collapse sheet
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: _collapseSheet,
                ),

                // Draggable thoughts list
                if (!isKeyboardVisible) _buildDraggableSheet(languageCode),

                // Centered input
                _buildCenteredInput(),
              ],
            ),
          ),
        );
      },
    );
  }

  // ───────────────── GESTURE HANDLERS ─────────────────

  void _handleSwipeRight(DragEndDetails details) async {
    if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
      await _saveThought();
    }
  }

  // ───────────────── WIDGETS ─────────────────

  Widget _buildCenteredInput() {
    return Align(
      alignment: const Alignment(0, -0.3),
      child: SizedBox(
        width: 500,
        child: ThoughtInput(controller: _textController),
      ),
    );
  }

  Widget _buildDraggableSheet(String languageCode) {
    return DraggableScrollableSheet(
      controller: _sheetController,
      initialChildSize: 0.15,
      minChildSize: 0.15,
      maxChildSize: 0.5,
      builder: (context, scrollController) {
        _currentScrollController = scrollController;

        return SafeArea(
          top: false,
          child: ClipPath(
            clipper: WaveClipper(),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSheetHeader(languageCode),
                  Expanded(
                    child: _buildThoughtsList(scrollController, languageCode),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSheetHeader(String languageCode) {
    return GestureDetector(
      onTap: _toggleSheet,
      onVerticalDragUpdate: (details) {
        if (details.delta.dy > 0) {
          _collapseSheet();
        } else {
          _toggleSheet();
        }
      },
      child: Container(
        width: double.infinity,
        height: 80,
        padding: const EdgeInsets.only(top: 24, left: 24, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                Strings.thoughts(languageCode),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const SettingsPage()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThoughtsList(
    ScrollController scrollController,
    String languageCode,
  ) {
    final groupTitles = Strings.groupTitles(languageCode);

    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      children: _groupedThoughts.entries.expand<Widget>((entry) {
        if (entry.value.isEmpty) return <Widget>[];

        return <Widget>[
          _buildGroupTitle(groupTitles[entry.key] ?? entry.key),
          ...entry.value.map((thought) => _buildThoughtCard(thought)),
        ];
      }).toList(),
    );
  }

  Widget _buildGroupTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.teal,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildThoughtCard(Thought thought) {
    return Dismissible(
      key: Key(thought.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => _deleteThought(thought.id),
      child: Card(
        color: const Color(0xFF23272A),
        margin: const EdgeInsets.symmetric(vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade700, width: 1),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _openThoughtDetails(thought),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  thought.text,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, height: 1.3),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('dd.MM').format(thought.createdAt),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      DateFormat('HH:mm').format(thought.createdAt),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
