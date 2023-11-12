import 'package:dio/dio.dart';
import 'package:school_app/src/modules/course/data/model/get_not_enrolled_students_model.dart';
import 'package:school_app/src/shared/services/dio_http_service.dart';

class EnrollStudentsToCourseUsecase {
  final DioHttpService _dioClient;

  EnrollStudentsToCourseUsecase(this._dioClient);

  Future<bool> call(int courseId, List<StudentModel> students) async {
    List<Future<Response<dynamic>>> requests = [];

    for (StudentModel student in students) {
      final request = _dioClient.post('/enrollments', {
        "courseId": courseId,
        "studentId": student.id,
      });

      requests.add(request);

      if (requests.length == 10) {
        await Future.wait(requests);
        requests = [];
      }
    }

    if (requests.isNotEmpty) await Future.wait(requests);

    return true;
  }
}
