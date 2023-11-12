// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeModel _$HomeModelFromJson(Map<String, dynamic> json) => HomeModel(
      students:
          StudentsInfoModel.fromJson(json['students'] as Map<String, dynamic>),
      courses:
          CoursesInfoModel.fromJson(json['courses'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HomeModelToJson(HomeModel instance) => <String, dynamic>{
      'students': instance.students,
      'courses': instance.courses,
    };

StudentsInfoModel _$StudentsInfoModelFromJson(Map<String, dynamic> json) =>
    StudentsInfoModel(
      studentsCount: json['studentsCount'] as int,
      enrollmentsCount: json['enrollmentsCount'] as int,
    );

Map<String, dynamic> _$StudentsInfoModelToJson(StudentsInfoModel instance) =>
    <String, dynamic>{
      'studentsCount': instance.studentsCount,
      'enrollmentsCount': instance.enrollmentsCount,
    };

CoursesInfoModel _$CoursesInfoModelFromJson(Map<String, dynamic> json) =>
    CoursesInfoModel(
      coursesCount: json['coursesCount'] as int,
      enrollmentsCount: json['enrollmentsCount'] as int,
    );

Map<String, dynamic> _$CoursesInfoModelToJson(CoursesInfoModel instance) =>
    <String, dynamic>{
      'coursesCount': instance.coursesCount,
      'enrollmentsCount': instance.enrollmentsCount,
    };
