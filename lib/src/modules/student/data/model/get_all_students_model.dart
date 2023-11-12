import 'package:json_annotation/json_annotation.dart';

part 'get_all_students_model.g.dart';

@JsonSerializable()
class GetAllStudentsModel {
  final List<StudentModel> students;
  GetAllStudentsModel({
    required this.students,
  });

  factory GetAllStudentsModel.fromJson(Map<String, dynamic> json) =>
      _$GetAllStudentsModelFromJson(json);
  Map<String, dynamic> toJson() => _$GetAllStudentsModelToJson(this);
}

@JsonSerializable()
class StudentModel {
  final int id;
  final String name;
  final DateTime birthDate;
  final String? courseName;

  StudentModel({
    required this.id,
    required this.name,
    required this.birthDate,
    this.courseName,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) =>
      _$StudentModelFromJson(json);
  Map<String, dynamic> toJson() => _$StudentModelToJson(this);

  String get formattedDate =>
      '${birthDate.day}/${birthDate.month}/${birthDate.year}';
}
