abstract class DeleteCourseState {}

class DeleteCourseInitial extends DeleteCourseState {}

class DeleteCourseLoading extends DeleteCourseState {}

class DeleteCourseSuccess extends DeleteCourseState {}

class DeleteCourseError extends DeleteCourseState {
  final String message;

  DeleteCourseError(this.message);
}
