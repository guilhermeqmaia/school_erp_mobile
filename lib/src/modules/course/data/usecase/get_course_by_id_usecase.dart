import 'package:school_app/src/modules/course/data/model/get_course_by_id_model.dart';
import 'package:school_app/src/shared/services/dio_http_service.dart';

class GetCourseByIdUsecase {
  final DioHttpService _dioClient;

  GetCourseByIdUsecase(this._dioClient);

  Future<GetCourseByIdModel> call(int courseId) async {
    final response = await _dioClient.get("/courses/$courseId");

    return GetCourseByIdModel.fromJson(response.data);
  }
}
