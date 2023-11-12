// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_courses_with_vacancies_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCoursesWithVacanciesModel _$GetCoursesWithVacanciesModelFromJson(
        Map<String, dynamic> json) =>
    GetCoursesWithVacanciesModel(
      courses: (json['courses'] as List<dynamic>)
          .map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetCoursesWithVacanciesModelToJson(
        GetCoursesWithVacanciesModel instance) =>
    <String, dynamic>{
      'courses': instance.courses,
    };

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) => CourseModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$CourseModelToJson(CourseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
