import 'package:flutter_modular/flutter_modular.dart';
import 'package:school_app/src/modules/course/data/model/get_course_by_id_model.dart';
import 'package:school_app/src/modules/course/data/usecase/create_course_usecase.dart';
import 'package:school_app/src/modules/course/data/usecase/delete_course_usecase.dart';
import 'package:school_app/src/modules/course/data/usecase/get_all_courses_usecase.dart';
import 'package:school_app/src/modules/course/data/usecase/get_course_by_id_usecase.dart';
import 'package:school_app/src/modules/course/data/usecase/get_not_enrolled_students_usecase.dart';
import 'package:school_app/src/modules/course/data/usecase/update_course_usecase.dart';
import 'package:school_app/src/modules/course/presentation/pages/course_listing/courses_listing_page.dart';
import 'package:school_app/src/modules/course/presentation/pages/course_register/course_register_page.dart';
import 'package:school_app/src/modules/course/presentation/pages/enroll_in_course/enroll_in_course_page.dart';
import 'package:school_app/src/modules/course/presentation/pages/enrolled_in_course/enrolled_in_course_page.dart';
import 'package:school_app/src/modules/course/presentation/stores/course_register/course_register_store.dart';
import 'package:school_app/src/modules/course/presentation/stores/courses_listing/courses_listing_store.dart';
import 'package:school_app/src/modules/course/presentation/stores/create_course/create_course_store.dart';

import 'presentation/stores/delete_course/delete_course_store.dart';
import 'presentation/stores/enroll_in_course/enroll_in_course_store.dart';

class CourseModule extends Module {
  @override
  List<Bind<Object>> binds = [
    //Usecases
    Bind.factory<GetAllCoursesUsecase>((i) => GetAllCoursesUsecase(i())),
    Bind.factory<DeleteCourseUsecase>((i) => DeleteCourseUsecase(i())),
    Bind.factory<CreateCourseUsecase>((i) => CreateCourseUsecase(i())),
    Bind.factory<GetCourseByIdUsecase>((i) => GetCourseByIdUsecase(i())),
    Bind.factory<UpdateCourseUsecase>((i) => UpdateCourseUsecase(i())),
    Bind.factory<GetNotEnrolledStudentsUsecase>(
      (i) => GetNotEnrolledStudentsUsecase(i()),
    ),

    //Stores
    Bind.lazySingleton<CoursesListingStore>((i) => CoursesListingStore(i())),
    Bind.lazySingleton<DeleteCourseStore>((i) => DeleteCourseStore(i())),
    Bind.lazySingleton<CreateCourseStore>((i) => CreateCourseStore(i())),
    Bind.lazySingleton<CourseRegisterStore>(
      (i) => CourseRegisterStore(i(), i(), i()),
    ),
    Bind.lazySingleton<EnrollInCourseStore>(
      (i) => EnrollInCourseStore(i(), i()),
    ),
  ];

  @override
  List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, __) => const CoursesListingPage(),
      transition: TransitionType.rightToLeft,
      duration: const Duration(milliseconds: 500),
    ),
    ChildRoute(
      '/register',
      child: (_, args) => CourseRegisterPage(
        courseId: int.parse(args.queryParams['id'] as String),
      ),
      transition: TransitionType.rightToLeft,
      duration: const Duration(milliseconds: 500),
    ),
    ChildRoute(
      '/register/enroll',
      child: (_, args) => EnrollInCoursePage(
        courseId: int.parse(args.queryParams['id'] as String),
        availableEnrollments:
            int.parse(args.queryParams['availableEnrollments'] as String),
      ),
      transition: TransitionType.rightToLeft,
      duration: const Duration(milliseconds: 500),
    ),
    ChildRoute(
      '/register/enrolled',
      child: (_, args) => EnrolledInCoursePage(
        courseId: int.parse(args.queryParams['id'] as String),
        students: args.data['students'] as List<CourseStudents>,
      ),
      transition: TransitionType.rightToLeft,
      duration: const Duration(milliseconds: 500),
    ),
  ];
}
