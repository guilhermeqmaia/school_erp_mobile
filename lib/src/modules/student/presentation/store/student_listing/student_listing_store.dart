import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_app/src/modules/student/data/usecase/delete_student_usecase.dart';
import 'package:school_app/src/modules/student/data/usecase/get_all_students_usecase.dart';
import 'package:school_app/src/modules/student/presentation/store/student_listing/student_listing_state.dart';
import 'package:school_app/src/modules/student/presentation/utils/delete_item_response_enum.dart';

class StudentListingStore extends Cubit<StudentListingState> {
  final GetAllStudentsUsecase _usecase;
  final DeleteStudentUsecase _deleteUsecase;

  StudentListingStore(
    this._usecase,
    this._deleteUsecase,
  ) : super(StudentListingInitial());

  void fetch() async {
    try {
      emit(StudentListingLoading());
      final model = await _usecase();
      emit(StudentListingSuccess(model));
    } catch (exception) {
      emit(StudentListingError('$exception'));
    }
  }

  Future<DeleteItemResponseEnum> deleteItem(int id) async {
    final initialState = state;
    try {
      await _deleteUsecase(id);
      fetch();
      return DeleteItemResponseEnum.sucess;
    } on DioException catch (exception) {
      emit(initialState);
      if (exception.response?.data['message'] == "Student has enrollments") {
        return DeleteItemResponseEnum.studentHasEnrollments;
      }
      return DeleteItemResponseEnum.error;
    }
  }
}
