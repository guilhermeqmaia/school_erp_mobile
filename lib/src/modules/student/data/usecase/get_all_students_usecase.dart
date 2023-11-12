import 'package:school_app/src/modules/student/data/model/get_all_students_model.dart';
import 'package:school_app/src/shared/services/dio_http_service.dart';

class GetAllStudentsUsecase {
  final DioHttpService _dioClient;

  GetAllStudentsUsecase(this._dioClient);

  Future<GetAllStudentsModel> call() async {
    final response = await _dioClient.get('/students');

    return GetAllStudentsModel.fromJson(response.data);
  }
}
