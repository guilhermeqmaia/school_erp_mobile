import 'package:school_app/src/shared/services/dio_http_service.dart';

class DeleteEnrollmentUsecase {
  final DioHttpService _dioClient;

  DeleteEnrollmentUsecase(this._dioClient);

  Future<void> call(int enrollmentId) async {
    await _dioClient.delete("/enrollments/$enrollmentId");
  }
}
