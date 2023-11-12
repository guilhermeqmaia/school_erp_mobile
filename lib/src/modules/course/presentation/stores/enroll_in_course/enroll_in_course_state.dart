import 'package:school_app/src/modules/course/data/model/get_not_enrolled_students_model.dart';

abstract class EnrollInCourseState {}

class EnrollInCourseInitial extends EnrollInCourseState {}

class EnrollInCourseLoading extends EnrollInCourseState {}

class EnrollInCourseSuccess extends EnrollInCourseState {
  final GetNotEnrolledStudentsModel model;

  EnrollInCourseSuccess(this.model);
}

class EnrollInCourseError extends EnrollInCourseState {
  final String message;

  EnrollInCourseError(this.message);
}
