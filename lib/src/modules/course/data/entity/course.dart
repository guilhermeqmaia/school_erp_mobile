import 'dart:convert';

class Course {
  final int? id;
  final String name;
  final String? description;
  final int? maxEnrollments;

  const Course({
    this.id,
    required this.name,
    this.description,
    this.maxEnrollments,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'maxEnrollments': maxEnrollments,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      maxEnrollments:
          map['maxEnrollments'] != null ? map['maxEnrollments'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) =>
      Course.fromMap(json.decode(source) as Map<String, dynamic>);
}
