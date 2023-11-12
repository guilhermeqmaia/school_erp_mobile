import 'package:json_annotation/json_annotation.dart';

part 'get_not_enrolled_students_model.g.dart';

@JsonSerializable()
class GetNotEnrolledStudentsModel {
  final List<StudentModel> students;
  GetNotEnrolledStudentsModel({
    required this.students,
  });

  factory GetNotEnrolledStudentsModel.fromJson(Map<String, dynamic> json) =>
      _$GetNotEnrolledStudentsModelFromJson(json);
  Map<String, dynamic> toJson() => _$GetNotEnrolledStudentsModelToJson(this);
}

@JsonSerializable()
class StudentModel {
  final int id;
  final String name;
  final DateTime birthDate;

  StudentModel({
    required this.id,
    required this.name,
    required this.birthDate,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) =>
      _$StudentModelFromJson(json);
  Map<String, dynamic> toJson() => _$StudentModelToJson(this);
}
