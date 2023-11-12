import 'package:school_app/src/modules/course/data/model/get_not_enrolled_students_model.dart';
import 'package:school_app/src/shared/services/dio_http_service.dart';

class GetNotEnrolledStudentsUsecase {
  final DioHttpService _dioClient;

  GetNotEnrolledStudentsUsecase(this._dioClient);

  Future<GetNotEnrolledStudentsModel> call() async {
    final response = await _dioClient.get("/students/not-enrolled");

    return GetNotEnrolledStudentsModel.fromJson(response.data);
  }
}
