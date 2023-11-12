import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_app/src/modules/student/data/entity/student.dart';
import 'package:school_app/src/modules/student/data/usecase/create_student_usecase.dart';
import 'package:school_app/src/modules/student/presentation/store/create_student/create_student_state.dart';

class CreateStudentStore extends Cubit<CreateStudentState> {
  final CreateStudentUsecase _usecase;

  CreateStudentStore(
    this._usecase,
  ) : super(CreateStudentInitial());

  Future<void> create(Student model) async {
    try {
      emit(CreateStudentLoading());
      await _usecase(model);
      emit(CreateStudentSuccess());
    } on DioException catch (exception) {
      emit(CreateStudentError('$exception'));
    }
  }
}
