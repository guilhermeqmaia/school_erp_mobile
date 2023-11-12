import 'package:json_annotation/json_annotation.dart';

part 'get_course_by_id_model.g.dart';

@JsonSerializable()
class GetCourseByIdModel {
  final int id;
  final String name;
  final int maxEnrollments;
  final String? description;
  final List<CourseStudents> students;
  GetCourseByIdModel({
    required this.id,
    required this.name,
    required this.maxEnrollments,
    this.description,
    this.students = const [],
  });

  factory GetCourseByIdModel.fromJson(Map<String, dynamic> json) =>
      _$GetCourseByIdModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetCourseByIdModelToJson(this);

  int get availableSlots => maxEnrollments - students.length;
}

@JsonSerializable()
class CourseStudents {
  final int enrollmentId;
  final int studentId;
  final String name;
  final DateTime birthDate;

  CourseStudents({
    required this.enrollmentId,
    required this.studentId,
    required this.name,
    required this.birthDate,
  });

  factory CourseStudents.fromJson(Map<String, dynamic> json) =>
      _$CourseStudentsFromJson(json);

  Map<String, dynamic> toJson() => _$CourseStudentsToJson(this);
}
