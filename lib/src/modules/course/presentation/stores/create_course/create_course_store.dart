import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_app/src/modules/course/data/entity/course.dart';
import 'package:school_app/src/modules/course/data/usecase/create_course_usecase.dart';
import 'package:school_app/src/modules/course/presentation/stores/create_course/create_course_state.dart';

class CreateCourseStore extends Cubit<CreateCourseState> {
  final CreateCourseUsecase _usecase;

  CreateCourseStore(this._usecase) : super(CreateCourseInitial());

  Future<void> create(Course course) async {
    try {
      emit(CreateCourseLoading());
      await _usecase(course);
      emit(CreateCourseSuccess());
    } on DioException catch (exception) {
      emit(CreateCourseError("${exception.message}"));
    }
  }
}
