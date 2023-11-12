import 'package:school_app/src/shared/services/dio_http_service.dart';

class DeleteCourseUsecase {
  final DioHttpService _dioClient;

  DeleteCourseUsecase(this._dioClient);

  Future<void> call(int id) async {
    await _dioClient.delete('/courses/$id');
  }
}
