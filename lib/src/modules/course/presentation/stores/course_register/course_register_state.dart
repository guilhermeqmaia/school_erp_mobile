import 'package:school_app/src/modules/course/data/model/get_course_by_id_model.dart';

abstract class CourseRegisterState {}

class CourseRegisterInitial extends CourseRegisterState {}

class CourseRegisterLoading extends CourseRegisterState {}

class CourseRegisterSuccess extends CourseRegisterState {
  final GetCourseByIdModel model;

  CourseRegisterSuccess(this.model);
}

class CourseRegisterError extends CourseRegisterState {
  final String message;

  CourseRegisterError(this.message);
}
