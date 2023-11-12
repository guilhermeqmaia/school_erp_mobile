import 'dart:convert';

class Student {
  final int? id;
  final String name;
  final DateTime birthDate;

  const Student({
    this.id,
    required this.name,
    required this.birthDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'birthDate': birthDate.toIso8601String(),
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      birthDate: DateTime.parse(map['birthDate'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);
}
