import 'package:school_app/src/shared/services/dio_http_service.dart';

class DeleteStudentUsecase {
  final DioHttpService _dioClient;

  DeleteStudentUsecase(this._dioClient);

  Future<void> call(int id) async {
    await _dioClient.delete('/students/$id');
  }
}
