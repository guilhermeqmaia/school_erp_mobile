import 'package:school_app/src/shared/services/dio_http_service.dart';

class EnrollToCourseUsecase {
  final DioHttpService _dioClient;

  EnrollToCourseUsecase(this._dioClient);

  Future<void> call(int courseId, int studentId) async {
    await _dioClient.post('/enrollments', {
      "courseId": courseId,
      "studentId": studentId,
    });
  }
}
