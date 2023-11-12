// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_not_enrolled_students_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetNotEnrolledStudentsModel _$GetNotEnrolledStudentsModelFromJson(
        Map<String, dynamic> json) =>
    GetNotEnrolledStudentsModel(
      students: (json['students'] as List<dynamic>)
          .map((e) => StudentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetNotEnrolledStudentsModelToJson(
        GetNotEnrolledStudentsModel instance) =>
    <String, dynamic>{
      'students': instance.students,
    };

StudentModel _$StudentModelFromJson(Map<String, dynamic> json) => StudentModel(
      id: json['id'] as int,
      name: json['name'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
    );

Map<String, dynamic> _$StudentModelToJson(StudentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'birthDate': instance.birthDate.toIso8601String(),
    };
