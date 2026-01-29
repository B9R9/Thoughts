import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../models/thought.dart';
import '../l10n/strings.dart';
import '../services/hive_service.dart';
import '../l10n/thoughts.dart';

class ThoughtPage extends StatefulWidget {
  final Thought thought;

  const ThoughtPage({super.key, required this.thought});

  @override
  State<ThoughtPage> createState() => _ThoughtPageState();
}

class _ThoughtPageState extends State<ThoughtPage> {
  late TextEditingController _controller;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.thought.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _saveThought(String languageCode) async {
    if (_controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ThoughtLocalization.emptyWarning(languageCode))),
      );
      return;
    }

    final updatedThought = Thought(
      id: widget.thought.id,
      text: _controller.text.trim(),
      createdAt: widget.thought.createdAt,
    );

    await HiveService.updateThought(updatedThought);

    setState(() {
      _isEditing = false;
    });

    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(ThoughtLocalization.saved(languageCode))));
    }
  }

  Future<void> _deleteThought(String languageCode) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(ThoughtLocalization.deleteTitle(languageCode)),
        content: Text(ThoughtLocalization.deleteMessage(languageCode)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(ThoughtLocalization.cancel(languageCode)),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(ThoughtLocalization.delete(languageCode)),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await HiveService.deleteThought(widget.thought.id);
      Navigator.of(
        context,
      ).pop(true); // Retourne true pour indiquer la suppression
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HiveService.settings.listenable(),
      builder: (context, Box settingsBox, _) {
        final languageCode =
            settingsBox.get('language', defaultValue: 'en') as String;

        return Scaffold(
          appBar: AppBar(
            title: Text(ThoughtLocalization.detailsTitle(languageCode)),
            actions: [
              if (!_isEditing)
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      _isEditing = true;
                    });
                  },
                ),
              if (_isEditing)
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () => _saveThought(languageCode),
                ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _deleteThought(languageCode),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date et heure
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      DateFormat(
                        'dd MMMM yyyy',
                      ).format(widget.thought.createdAt),
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      DateFormat('HH:mm').format(widget.thought.createdAt),
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Contenu de la pensée
                Expanded(
                  child: _isEditing
                      ? TextField(
                          controller: _controller,
                          maxLines: null,
                          expands: true,
                          autofocus: true,
                          textAlignVertical: TextAlignVertical.top,
                          style: const TextStyle(
                            fontSize: 19,
                            height: 1.6,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: Strings.hintInput(languageCode),
                            filled: true,
                            fillColor: const Color(0xFF1E1E1E),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              widget.thought.text,
                              style: const TextStyle(
                                fontSize: 19,
                                height: 1.6,
                                letterSpacing: 0.1,
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
