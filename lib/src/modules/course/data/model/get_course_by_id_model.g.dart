// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_course_by_id_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCourseByIdModel _$GetCourseByIdModelFromJson(Map<String, dynamic> json) =>
    GetCourseByIdModel(
      id: json['id'] as int,
      name: json['name'] as String,
      maxEnrollments: json['maxEnrollments'] as int,
      description: json['description'] as String?,
      students: (json['students'] as List<dynamic>?)
              ?.map((e) => CourseStudents.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GetCourseByIdModelToJson(GetCourseByIdModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'maxEnrollments': instance.maxEnrollments,
      'description': instance.description,
      'students': instance.students,
    };

CourseStudents _$CourseStudentsFromJson(Map<String, dynamic> json) =>
    CourseStudents(
      enrollmentId: json['enrollmentId'] as int,
      studentId: json['studentId'] as int,
      name: json['name'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
    );

Map<String, dynamic> _$CourseStudentsToJson(CourseStudents instance) =>
    <String, dynamic>{
      'enrollmentId': instance.enrollmentId,
      'studentId': instance.studentId,
      'name': instance.name,
      'birthDate': instance.birthDate.toIso8601String(),
    };
