import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_app/src/modules/course/data/usecase/get_all_courses_usecase.dart';
import 'package:school_app/src/modules/course/presentation/stores/courses_listing/courses_listing_state.dart';

class CoursesListingStore extends Cubit<CoursesListingState> {
  final GetAllCoursesUsecase _usecase;

  CoursesListingStore(
    this._usecase,
  ) : super(CoursesListingInitial());

  void fetch() async {
    try {
      emit(CoursesListingLoading());
      final result = await _usecase();
      emit(CoursesListingSuccess(result));
    } catch (exception) {
      emit(CoursesListingError(exception.toString()));
    }
  }
}
