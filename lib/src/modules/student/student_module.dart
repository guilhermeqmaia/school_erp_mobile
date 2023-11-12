import 'package:flutter_modular/flutter_modular.dart';
import 'package:school_app/src/modules/student/data/usecase/create_student_usecase.dart';
import 'package:school_app/src/modules/student/data/usecase/delete_student_usecase.dart';
import 'package:school_app/src/modules/student/data/usecase/enroll_to_course_usecase.dart';
import 'package:school_app/src/modules/student/data/usecase/get_all_students_usecase.dart';
import 'package:school_app/src/modules/student/data/usecase/get_courses_with_vacancies_usecase.dart';
import 'package:school_app/src/modules/student/data/usecase/get_student_by_id_usecase.dart';
import 'package:school_app/src/modules/student/data/usecase/update_student_usecase.dart';
import 'package:school_app/src/modules/student/presentation/pages/student_listing/student_listing_page.dart';
import 'package:school_app/src/modules/student/presentation/pages/student_register/student_register_page.dart';
import 'package:school_app/src/modules/student/presentation/store/enroll_to_course/enroll_to_course_store.dart';
import 'package:school_app/src/modules/student/presentation/store/student_listing/student_listing_store.dart';

import 'presentation/pages/enroll_to_course/enroll_to_course_page.dart';
import 'presentation/store/create_student/create_student_store.dart';
import 'presentation/store/student_register/student_register_store.dart';

class StudentModule extends Module {
  @override
  List<Bind<Object>> binds = [
    ///Usecases
    Bind.factory<GetAllStudentsUsecase>((i) => GetAllStudentsUsecase(i())),
    Bind.factory<DeleteStudentUsecase>((i) => DeleteStudentUsecase(i())),
    Bind.factory<CreateStudentUsecase>((i) => CreateStudentUsecase(i())),
    Bind.factory<GetStudentByIdUsecase>((i) => GetStudentByIdUsecase(i())),
    Bind.factory<UpdateStudentUsecase>((i) => UpdateStudentUsecase(i())),
    Bind.factory<GetCoursesWithVacanciesUsecase>(
      (i) => GetCoursesWithVacanciesUsecase(i()),
    ),
    Bind.factory<EnrollToCourseUsecase>((i) => EnrollToCourseUsecase(i())),

    ///Stores
    Bind.lazySingleton<StudentListingStore>(
      (i) => StudentListingStore(i(), i()),
    ),
    Bind.lazySingleton<CreateStudentStore>(
      (i) => CreateStudentStore(i()),
    ),
    Bind.lazySingleton<StudentRegisterStore>(
      (i) => StudentRegisterStore(i(), i(), i()),
    ),
    Bind.lazySingleton<EnrollToCourseStore>(
      (i) => EnrollToCourseStore(i(), i()),
    ),
  ];

  @override
  List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, __) => const StudentListingPage(),
    ),
    ChildRoute(
      '/register',
      child: (_, args) => StudentRegisterPage(
        studentId: int.parse(args.queryParams['id'] as String),
      ),
    ),
    ChildRoute(
      '/register/enroll',
      child: (_, args) => EnrollToCoursePage(
        studentId: int.parse(args.queryParams['id'] as String),
      ),
    ),
  ];
}
