import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../models/thought.dart';

class HiveService {
  static const String thoughtsBox = 'thoughts';
  static const String settingsBox = 'settings';
  static const _secureStorage = FlutterSecureStorage();

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ThoughtAdapter());
    await Hive.openBox(settingsBox);
    final settings = Hive.box(settingsBox);
    if (settings.get('first_run', defaultValue: true) as bool) {
      await _secureStorage.delete(key: 'pin_code');
      await settings.put('first_run', false);
    }
    if (!(settings.get('thoughts_encrypted', defaultValue: false) as bool)) {
      await Hive.deleteBoxFromDisk(thoughtsBox);
      await settings.put('thoughts_encrypted', true);
    }
    final storedKey = await _secureStorage.read(key: 'thoughts_key');
    final encryptionKey = storedKey == null
        ? Hive.generateSecureKey()
        : base64Url.decode(storedKey);
    if (storedKey == null) {
      await _secureStorage.write(
        key: 'thoughts_key',
        value: base64UrlEncode(encryptionKey),
      );
    }
    await Hive.openBox<Thought>(
      thoughtsBox,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );
    await _seedThoughtsIfNeeded();
  }

  static Box<Thought> get box => Hive.box<Thought>(thoughtsBox);
  static Box get settings => Hive.box(settingsBox);

  static Future<List<Thought>> getThoughts() async {
    final thoughts = box.values.toList();
    thoughts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return thoughts;
  }

  static Future<Thought> addThought(String text) async {
    final thought = Thought(
      id: const Uuid().v4(),
      text: text.trim(),
      createdAt: DateTime.now(),
    );
    await box.put(thought.id, thought);
    return thought;
  }

  static Future<void> updateThought(Thought thought) async {
    await box.put(thought.id, thought);
  }

  static Future<void> deleteThought(String id) async {
    await box.delete(id);
  }

  static Future<void> clearThoughts() async {
    await box.clear();
  }

  static Future<void> _seedThoughtsIfNeeded() async {
    if (!kDebugMode) return;
    final thoughts = Hive.box<Thought>(thoughtsBox);
    if (thoughts.isNotEmpty) return;

    final now = DateTime.now();
    final seedThoughts = [
      Thought(
        id: const Uuid().v4(),
        text: 'Premiere pensee pour tester la lecture.',
        createdAt: now.subtract(const Duration(minutes: 10)),
      ),
      Thought(
        id: const Uuid().v4(),
        text: 'Deuxieme pensee, un peu plus longue pour voir le rendu.',
        createdAt: now.subtract(const Duration(hours: 2)),
      ),
      Thought(
        id: const Uuid().v4(),
        text: 'Une idee rapide avant de dormir.',
        createdAt: now.subtract(const Duration(days: 1)),
      ),
    ];
    for (final thought in seedThoughts) {
      await thoughts.put(thought.id, thought);
    }
  }
}
