import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_app/src/modules/student/data/usecase/enroll_to_course_usecase.dart';
import 'package:school_app/src/modules/student/data/usecase/get_courses_with_vacancies_usecase.dart';
import 'package:school_app/src/modules/student/presentation/store/enroll_to_course/enroll_to_course_state.dart';

class EnrollToCourseStore extends Cubit<EnrollToCourseState> {
  final GetCoursesWithVacanciesUsecase _usecase;
  final EnrollToCourseUsecase _enrollToCourseUsecase;

  EnrollToCourseStore(
    this._usecase,
    this._enrollToCourseUsecase,
  ) : super(EnrollToCourseInitial());

  void fetch() async {
    try {
      emit(EnrollToCourseLoading());
      final model = await _usecase();
      emit(EnrollToCourseSuccess(model));
    } catch (exception) {
      emit(EnrollToCourseError('$exception'));
    }
  }

  Future<EnrollInCourseResponseEnum> enroll(int courseId, int studentId) async {
    try {
      await _enrollToCourseUsecase(
        courseId,
        studentId,
      );
      return EnrollInCourseResponseEnum.success;
    } on DioException catch (exception) {
      if (exception.response?.data['message'] == "Enrollment limit reached") {
        return EnrollInCourseResponseEnum.enrollmentLimitReached;
      }
      return EnrollInCourseResponseEnum.error;
    }
  }
}

enum EnrollInCourseResponseEnum { success, enrollmentLimitReached, error }
