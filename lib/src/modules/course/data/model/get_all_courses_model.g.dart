// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_courses_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllCoursesModel _$GetAllCoursesModelFromJson(Map<String, dynamic> json) =>
    GetAllCoursesModel(
      courses: (json['courses'] as List<dynamic>)
          .map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllCoursesModelToJson(GetAllCoursesModel instance) =>
    <String, dynamic>{
      'courses': instance.courses,
    };

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) => CourseModel(
      id: json['id'] as int,
      name: json['name'] as String,
      maxEnrollments: json['maxEnrollments'] as int,
      description: json['description'] as String?,
      enrolledStudentsCount: json['enrolledStudentsCount'] as int,
    );

Map<String, dynamic> _$CourseModelToJson(CourseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'maxEnrollments': instance.maxEnrollments,
      'description': instance.description,
      'enrolledStudentsCount': instance.enrolledStudentsCount,
    };
