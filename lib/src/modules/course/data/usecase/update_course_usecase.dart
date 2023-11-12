import 'package:school_app/src/modules/course/data/entity/course.dart';
import 'package:school_app/src/shared/services/dio_http_service.dart';

class UpdateCourseUsecase {
  final DioHttpService _dioClient;

  UpdateCourseUsecase(this._dioClient);

  Future<void> call(int courseId, Course course) async {
    await _dioClient.put("/courses", {
      "id": courseId,
      "course": course.toJson(),
    });
  }
}
