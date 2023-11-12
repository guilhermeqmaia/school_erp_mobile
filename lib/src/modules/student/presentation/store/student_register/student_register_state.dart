import 'package:school_app/src/modules/student/data/model/get_student_by_id_model.dart';

abstract class StudentRegisterState {}

class StudentRegisterInitial extends StudentRegisterState {}

class StudentRegisterLoading extends StudentRegisterState {}

class StudentRegisterSuccess extends StudentRegisterState {
  final GetStudentByIdModel model;

  StudentRegisterSuccess(this.model);
}

class StudentRegisterError extends StudentRegisterState {
  final String message;

  StudentRegisterError(this.message);
}
