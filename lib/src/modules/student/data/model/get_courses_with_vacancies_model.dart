import 'package:json_annotation/json_annotation.dart';

part 'get_courses_with_vacancies_model.g.dart';

@JsonSerializable()
class GetCoursesWithVacanciesModel {
  final List<CourseModel> courses;
  GetCoursesWithVacanciesModel({
    required this.courses,
  });

  factory GetCoursesWithVacanciesModel.fromJson(Map<String, dynamic> json) =>
      _$GetCoursesWithVacanciesModelFromJson(json);
  Map<String, dynamic> toJson() => _$GetCoursesWithVacanciesModelToJson(this);
}

@JsonSerializable()
class CourseModel {
  final int id;
  final String name;

  CourseModel({
    required this.id,
    required this.name,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);
  Map<String, dynamic> toJson() => _$CourseModelToJson(this);
}
