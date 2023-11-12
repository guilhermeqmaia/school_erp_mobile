import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_app/src/modules/course/data/entity/course.dart';
import 'package:school_app/src/modules/course/data/usecase/get_course_by_id_usecase.dart';
import 'package:school_app/src/modules/course/data/usecase/update_course_usecase.dart';
import 'package:school_app/src/modules/course/presentation/stores/course_register/course_register_state.dart';
import 'package:school_app/src/shared/data/usecase/delete_enrollment_usecase.dart';

class CourseRegisterStore extends Cubit<CourseRegisterState> {
  final GetCourseByIdUsecase _usecase;
  final UpdateCourseUsecase _updateCourseUsecase;
  final DeleteEnrollmentUsecase _deleteEnrollmentUsecase;

  CourseRegisterStore(
    this._usecase,
    this._updateCourseUsecase,
    this._deleteEnrollmentUsecase,
  ) : super(CourseRegisterInitial());

  Future<void> fetch(id) async {
    try {
      emit(CourseRegisterLoading());
      final model = await _usecase(id);
      emit(CourseRegisterSuccess(model));
    } catch (e) {
      emit(CourseRegisterError(e.toString()));
    }
  }

  Future<bool> save(Course course) async {
    final initialState = state;
    try {
      emit(CourseRegisterLoading());
      await _updateCourseUsecase(course.id!, course);
      emit(initialState);
      return true;
    } catch (e) {
      emit(initialState);
      return false;
    }
  }

  Future<bool> deleteEnrollment(int enrollmentId) async {
    final initialState = state;
    try {
      emit(CourseRegisterLoading());
      await _deleteEnrollmentUsecase(enrollmentId);
      emit(initialState);
      return true;
    } catch (e) {
      emit(initialState);
      return false;
    }
  }
}
