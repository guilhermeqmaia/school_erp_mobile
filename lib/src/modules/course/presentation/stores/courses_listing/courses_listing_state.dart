import 'package:school_app/src/modules/course/data/model/get_all_courses_model.dart';

abstract class CoursesListingState {}

class CoursesListingInitial extends CoursesListingState {}

class CoursesListingLoading extends CoursesListingState {}

class CoursesListingSuccess extends CoursesListingState {
  final GetAllCoursesModel model;

  CoursesListingSuccess(this.model);
}

class CoursesListingError extends CoursesListingState {
  final String message;

  CoursesListingError(this.message);
}
