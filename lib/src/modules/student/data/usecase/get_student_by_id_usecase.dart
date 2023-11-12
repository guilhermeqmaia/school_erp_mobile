import 'package:school_app/src/modules/student/data/model/get_student_by_id_model.dart';
import 'package:school_app/src/shared/services/dio_http_service.dart';

class GetStudentByIdUsecase {
  final DioHttpService _dioClient;

  GetStudentByIdUsecase(this._dioClient);

  Future<GetStudentByIdModel> call(int id) async {
    final response = await _dioClient.get('/students/$id');

    return GetStudentByIdModel.fromJson(response.data);
  }
}
