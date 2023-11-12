import 'package:flutter_modular/flutter_modular.dart';
import 'package:school_app/src/modules/course/course_module.dart';
import 'package:school_app/src/modules/home/home_module.dart';
import 'package:school_app/src/modules/student/student_module.dart';
import 'package:school_app/src/shared/data/usecase/delete_enrollment_usecase.dart';
import 'package:school_app/src/shared/data/usecase/enroll_students_to_course_usecase.dart';
import 'package:school_app/src/shared/services/dio_http_service.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> binds = [
    //Services
    Bind.factory<DioHttpService>((i) => DioHttpService()),

    //Usecases
    Bind.factory<EnrollStudentsToCourseUsecase>(
      (i) => EnrollStudentsToCourseUsecase(i()),
    ),
    Bind.factory<DeleteEnrollmentUsecase>((i) => DeleteEnrollmentUsecase(i())),
  ];

  @override
  List<ModularRoute> routes = [
    ModuleRoute(
      '/',
      module: HomeModule(),
    ),
    ModuleRoute(
      '/course',
      module: CourseModule(),
    ),
    ModuleRoute(
      '/student',
      module: StudentModule(),
    )
  ];
}
