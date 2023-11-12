import 'package:school_app/src/modules/course/data/model/get_all_courses_model.dart';
import 'package:school_app/src/shared/services/dio_http_service.dart';

class GetAllCoursesUsecase {
  final DioHttpService _dioClient;

  GetAllCoursesUsecase(this._dioClient);

  Future<GetAllCoursesModel> call() async {
    final response = await _dioClient.get('/courses');

    return GetAllCoursesModel.fromJson(response.data);
  }
}
