import 'package:school_app/src/modules/student/data/entity/student.dart';
import 'package:school_app/src/shared/services/dio_http_service.dart';

class UpdateStudentUsecase {
  final DioHttpService _dioClient;

  UpdateStudentUsecase(this._dioClient);

  Future<void> call(Student model) async {
    await _dioClient.put('/students', {
      "id": model.id,
      "student": model.toJson(),
    });
  }
}
