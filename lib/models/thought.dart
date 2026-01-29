import 'dart:convert';
import 'package:hive/hive.dart';
part 'thought.g.dart';

@HiveType(typeId: 0)
class Thought extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String text;
  @HiveField(2)
  final DateTime createdAt;

  Thought({required this.id, required this.text, required this.createdAt});

  /// Thought → Map (pour storage local)
  Map<String, dynamic> toMap() {
    return {'id': id, 'text': text, 'createdAt': createdAt.toIso8601String()};
  }

  /// Map → Thought
  factory Thought.fromMap(Map<String, dynamic> map) {
    return Thought(
      id: map['id'] as String,
      text: map['text'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  /// Thought → JSON
  String toJson() => jsonEncode(toMap());

  /// JSON → Thought
  factory Thought.fromJson(String source) =>
      Thought.fromMap(jsonDecode(source));
}
