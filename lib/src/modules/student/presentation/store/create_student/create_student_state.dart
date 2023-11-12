abstract class CreateStudentState {}

class CreateStudentInitial extends CreateStudentState {}

class CreateStudentLoading extends CreateStudentState {}

class CreateStudentSuccess extends CreateStudentState {}

class CreateStudentError extends CreateStudentState {
  final String message;

  CreateStudentError(this.message);
}
