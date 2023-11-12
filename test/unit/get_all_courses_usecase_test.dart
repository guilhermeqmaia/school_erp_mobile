import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:school_app/src/modules/course/data/model/get_all_courses_model.dart';
import 'package:school_app/src/modules/course/data/usecase/get_all_courses_usecase.dart';
import 'package:school_app/src/shared/services/dio_http_service.dart';

import '../helpers/api_data_factory.dart';
import '../helpers/test_response.dart';

class _DioMock extends Mock implements DioHttpService {}

void main() {
  late DioHttpService dioMock;
  late GetAllCoursesUsecase sut;

  setUpAll(() {
    dioMock = _DioMock();
    sut = GetAllCoursesUsecase(dioMock);
  });

  When whenGetAllCourses() => when(() => dioMock.get("/courses"));

  test('WHEN call get all courses THEN ensure return is expected', () async {
    //Arrange
    whenGetAllCourses().thenAnswer(
      (_) async => TestResponse(ApiDataFactory.mockGetAllCoursesUsecase()),
    );
    //Act
    final result = await sut();
    //Assert
    expect(result, isA<GetAllCoursesModel>());
  });
}
