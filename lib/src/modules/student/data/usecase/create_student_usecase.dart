import 'package:school_app/src/modules/student/data/entity/student.dart';
import 'package:school_app/src/shared/services/dio_http_service.dart';

class CreateStudentUsecase {
  final DioHttpService _dioClient;

  CreateStudentUsecase(this._dioClient);

  Future<void> call(Student model) async {
    await _dioClient.post('/students', model.toJson());
  }
}
