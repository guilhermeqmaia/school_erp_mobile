import 'package:school_app/src/modules/student/data/model/get_all_students_model.dart';

abstract class StudentListingState {}

class StudentListingInitial extends StudentListingState {}

class StudentListingLoading extends StudentListingState {}

class StudentListingSuccess extends StudentListingState {
  final GetAllStudentsModel model;

  StudentListingSuccess(this.model);
}

class StudentListingError extends StudentListingState {
  final String message;

  StudentListingError(this.message);
}
