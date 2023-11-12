import 'package:school_app/src/modules/course/data/entity/course.dart';
import 'package:school_app/src/shared/services/dio_http_service.dart';

class CreateCourseUsecase {
  final DioHttpService _dioClient;

  CreateCourseUsecase(this._dioClient);

  Future<void> call(Course course) async {
    await _dioClient.post("/courses", course.toJson());
  }
}
