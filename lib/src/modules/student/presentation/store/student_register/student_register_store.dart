import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_app/src/modules/student/data/entity/student.dart';
import 'package:school_app/src/modules/student/data/usecase/get_student_by_id_usecase.dart';
import 'package:school_app/src/modules/student/data/usecase/update_student_usecase.dart';
import 'package:school_app/src/shared/data/usecase/delete_enrollment_usecase.dart';

import 'student_register_state.dart';

class StudentRegisterStore extends Cubit<StudentRegisterState> {
  final GetStudentByIdUsecase _usecase;
  final DeleteEnrollmentUsecase _deleteEnrollmentUsecase;
  final UpdateStudentUsecase _updateStudentUsecase;

  StudentRegisterStore(
    this._usecase,
    this._deleteEnrollmentUsecase,
    this._updateStudentUsecase,
  ) : super(StudentRegisterInitial());

  void fetch(int id) async {
    try {
      emit(StudentRegisterLoading());
      final model = await _usecase(id);
      emit(StudentRegisterSuccess(model));
    } catch (exception) {
      emit(StudentRegisterError('$exception'));
    }
  }

  Future<bool> deleteEnrollment(int enrollmentId) async {
    final initialState = state;
    try {
      emit(StudentRegisterLoading());
      await _deleteEnrollmentUsecase(enrollmentId);
      emit(initialState);
      return true;
    } catch (exception) {
      emit(initialState);
      return false;
    }
  }

  Future<bool> save(Student model) async {
    try {
      await _updateStudentUsecase(model);
      return true;
    } on DioException {
      return false;
    }
  }
}
