// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_student_by_id_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetStudentByIdModel _$GetStudentByIdModelFromJson(Map<String, dynamic> json) =>
    GetStudentByIdModel(
      id: json['id'] as int,
      name: json['name'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      enrollmentId: json['enrollmentId'] as int?,
      courseId: json['courseId'] as int?,
      courseName: json['courseName'] as String?,
    );

Map<String, dynamic> _$GetStudentByIdModelToJson(
        GetStudentByIdModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'birthDate': instance.birthDate.toIso8601String(),
      'enrollmentId': instance.enrollmentId,
      'courseId': instance.courseId,
      'courseName': instance.courseName,
    };
