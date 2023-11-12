import 'package:school_app/src/modules/student/data/model/get_courses_with_vacancies_model.dart';

abstract class EnrollToCourseState {}

class EnrollToCourseInitial extends EnrollToCourseState {}

class EnrollToCourseLoading extends EnrollToCourseState {}

class EnrollToCourseSuccess extends EnrollToCourseState {
  final GetCoursesWithVacanciesModel model;

  EnrollToCourseSuccess(this.model);
}

class EnrollToCourseError extends EnrollToCourseState {
  final String message;

  EnrollToCourseError(this.message);
}
