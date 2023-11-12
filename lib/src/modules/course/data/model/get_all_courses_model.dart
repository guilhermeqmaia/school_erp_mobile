import 'package:json_annotation/json_annotation.dart';

part 'get_all_courses_model.g.dart';

@JsonSerializable()
class GetAllCoursesModel {
  final List<CourseModel> courses;

  GetAllCoursesModel({
    required this.courses,
  });

  factory GetAllCoursesModel.fromJson(Map<String, dynamic> json) =>
      _$GetAllCoursesModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllCoursesModelToJson(this);
}

@JsonSerializable()
class CourseModel {
  final int id;
  final String name;
  final int maxEnrollments;
  final String? description;
  final int enrolledStudentsCount;

  CourseModel({
    required this.id,
    required this.name,
    required this.maxEnrollments,
    this.description,
    required this.enrolledStudentsCount,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseModelToJson(this);
}
