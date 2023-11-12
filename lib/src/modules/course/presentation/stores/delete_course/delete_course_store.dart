import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_app/src/modules/course/data/usecase/delete_course_usecase.dart';
import 'package:school_app/src/modules/course/presentation/stores/delete_course/delete_course_state.dart';

class DeleteCourseStore extends Cubit<DeleteCourseState> {
  final DeleteCourseUsecase _usecase;

  DeleteCourseStore(
    this._usecase,
  ) : super(DeleteCourseInitial());

  Future<void> delete(int courseId) async {
    try {
      emit(DeleteCourseLoading());
      await _usecase(courseId);
      emit(DeleteCourseSuccess());
    } on DioException catch (exception) {
      if (exception.response?.data['message'] ==
          "Course has students enrolled") {
        emit(DeleteCourseError("Course has students enrolled"));
      } else {
        emit(DeleteCourseError(exception.toString()));
      }
    } catch (exception) {
      emit(DeleteCourseError(exception.toString()));
    }
  }
}
