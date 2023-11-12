abstract class CreateCourseState {}

class CreateCourseInitial extends CreateCourseState {}

class CreateCourseLoading extends CreateCourseState {}

class CreateCourseSuccess extends CreateCourseState {}

class CreateCourseError extends CreateCourseState {
  final String message;

  CreateCourseError(this.message);
}
