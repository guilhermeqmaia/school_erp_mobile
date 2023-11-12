import 'package:json_annotation/json_annotation.dart';

part 'get_student_by_id_model.g.dart';

@JsonSerializable()
class GetStudentByIdModel {
  final int id;
  final String name;
  final DateTime birthDate;
  final int? enrollmentId;
  final int? courseId;
  final String? courseName;

  GetStudentByIdModel({
    required this.id,
    required this.name,
    required this.birthDate,
    this.enrollmentId,
    this.courseId,
    this.courseName,
  });

  factory GetStudentByIdModel.fromJson(Map<String, dynamic> json) =>
      _$GetStudentByIdModelFromJson(json);
  Map<String, dynamic> toJson() => _$GetStudentByIdModelToJson(this);
}
