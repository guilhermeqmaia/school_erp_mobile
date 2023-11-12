import 'package:school_app/src/modules/student/data/model/get_courses_with_vacancies_model.dart';
import 'package:school_app/src/shared/services/dio_http_service.dart';

class GetCoursesWithVacanciesUsecase {
  final DioHttpService _dioClient;

  GetCoursesWithVacanciesUsecase(this._dioClient);

  Future<GetCoursesWithVacanciesModel> call() async {
    final response = await _dioClient.get('/courses/with-vacancies');

    return GetCoursesWithVacanciesModel.fromJson(response.data);
  }
}
