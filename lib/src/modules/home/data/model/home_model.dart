import 'package:json_annotation/json_annotation.dart';

part 'home_model.g.dart';

@JsonSerializable()
class HomeModel {
  final StudentsInfoModel students;
  final CoursesInfoModel courses;

  HomeModel({
    required this.students,
    required this.courses,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) =>
      _$HomeModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeModelToJson(this);
}

@JsonSerializable()
class StudentsInfoModel {
  final int studentsCount;
  final int enrollmentsCount;

  StudentsInfoModel({
    required this.studentsCount,
    required this.enrollmentsCount,
  });

  factory StudentsInfoModel.fromJson(Map<String, dynamic> json) =>
      _$StudentsInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudentsInfoModelToJson(this);
}

@JsonSerializable()
class CoursesInfoModel {
  final int coursesCount;
  final int enrollmentsCount;

  CoursesInfoModel({
    required this.coursesCount,
    required this.enrollmentsCount,
  });

  factory CoursesInfoModel.fromJson(Map<String, dynamic> json) =>
      _$CoursesInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoursesInfoModelToJson(this);
}
