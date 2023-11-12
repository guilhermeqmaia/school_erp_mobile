import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_app/src/modules/course/data/model/get_not_enrolled_students_model.dart';
import 'package:school_app/src/modules/course/data/usecase/get_not_enrolled_students_usecase.dart';
import 'package:school_app/src/modules/course/presentation/stores/enroll_in_course/enroll_in_course_state.dart';
import 'package:school_app/src/shared/data/usecase/enroll_students_to_course_usecase.dart';

class EnrollInCourseStore extends Cubit<EnrollInCourseState> {
  final GetNotEnrolledStudentsUsecase _usecase;
  final EnrollStudentsToCourseUsecase _enrollStudentsToCourseUsecase;

  EnrollInCourseStore(
    this._usecase,
    this._enrollStudentsToCourseUsecase,
  ) : super(EnrollInCourseInitial());

  Future<void> fetch() async {
    try {
      emit(EnrollInCourseLoading());
      final result = await _usecase();
      emit(EnrollInCourseSuccess(result));
    } catch (e) {
      emit(EnrollInCourseError(e.toString()));
    }
  }

  Future<EnrollInCourseResponseEnum> enroll(
      List<StudentModel> students, int courseId) async {
    final initialState = state;
    try {
      emit(EnrollInCourseLoading());
      await _enrollStudentsToCourseUsecase(courseId, students);
      emit(initialState);
      return EnrollInCourseResponseEnum.success;
    } on DioException catch (exception) {
      emit(initialState);
      if (exception.response?.data['message'] == "Enrollment limit reached") {
        return EnrollInCourseResponseEnum.enrollmentLimitReached;
      }
      return EnrollInCourseResponseEnum.error;
    }
  }
}

enum EnrollInCourseResponseEnum { success, enrollmentLimitReached, error }
