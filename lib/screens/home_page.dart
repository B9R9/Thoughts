import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../models/thought.dart';
import '../services/hive_service.dart';
import '../l10n/strings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  final _listKey = GlobalKey<AnimatedListState>();

  late Box settingsBox;
  final List<Thought> _thoughts = [];

  @override
  void initState() {
    super.initState();
    settingsBox = HiveService.settings;
    _loadThoughts();
  }

  Future<void> _loadThoughts() async {
    _thoughts
      ..clear()
      ..addAll(await HiveService.getThoughts());
  }

  void _addThought() async {
    if (_controller.text.trim().isEmpty) return;

    final thought = await HiveService.addThought(_controller.text);

    setState(() {
      _thoughts.insert(0, thought);
    });

    _listKey.currentState?.insertItem(
      0,
      duration: const Duration(milliseconds: 300),
    );

    HapticFeedback.lightImpact();
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: settingsBox.listenable(),
      builder: (context, Box box, _) {
        final languageCode = box.get('language', defaultValue: 'en') as String;

        return Scaffold(
          backgroundColor: const Color(0xFF121212),
          appBar: AppBar(
            title: Text(Strings.thoughts(languageCode)),
            centerTitle: true,
          ),
          body: Column(
            children: [
              _buildInput(languageCode),
              const Divider(height: 1),
              Expanded(child: _buildList()),
            ],
          ),
        );
      },
    );
  }

  // ───────────────── INPUT ─────────────────

  Widget _buildInput(String languageCode) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: Strings.hintInput(languageCode),
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFF1E1E1E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (_) => _addThought(),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(icon: const Icon(Icons.send), onPressed: _addThought),
        ],
      ),
    );
  }

  // ───────────────── LISTE ANIMÉE ─────────────────

  Widget _buildList() {
    return AnimatedList(
      key: _listKey,
      initialItemCount: _thoughts.length,
      itemBuilder: (context, index, animation) {
        final thought = _thoughts[index];

        return SizeTransition(
          sizeFactor: animation,
          axisAlignment: -1,
          child: FadeTransition(
            opacity: animation,
            child: _buildThoughtCard(thought),
          ),
        );
      },
    );
  }

  // ───────────────── CARD ─────────────────

  Widget _buildThoughtCard(Thought thought) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      color: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(thought.text, style: const TextStyle(color: Colors.white)),
        subtitle: Text(
          DateFormat('dd/MM/yyyy HH:mm').format(thought.createdAt.toLocal()),
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
