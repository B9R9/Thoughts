import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../l10n/strings.dart';
import '../services/hive_service.dart';

class ThoughtInput extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;

  const ThoughtInput({super.key, this.focusNode, this.controller});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HiveService.settings.listenable(),
      builder: (context, Box settingsBox, _) {
        final languageCode =
            settingsBox.get('language', defaultValue: 'en') as String;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: TextField(
            focusNode: focusNode,
            controller: controller,
            maxLines: null,
            minLines: 1,
            cursorColor: Colors.teal,
            cursorWidth: 2,
            cursorRadius: const Radius.circular(4),
            style: const TextStyle(fontSize: 18),
            decoration: InputDecoration(
              hintText: Strings.hintInput(languageCode),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 16.0,
              ),
            ),
          ),
        );
      },
    );
  }
}
