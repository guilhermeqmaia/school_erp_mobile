import 'package:school_app/src/modules/course/data/model/get_all_courses_model.dart';

class ApiDataFactory {
  static Map<String, dynamic> mockGetAllCoursesUsecase() {
    final courses = List.generate(
      5,
      (index) => CourseModel(
        id: index,
        name: "$index",
        maxEnrollments: index * 5,
        enrolledStudentsCount: 5,
      ),
    );

    final model = GetAllCoursesModel(
      courses: courses,
    ).toJson();

    model['courses'] = courses.map((e) => e.toJson()).toList();

    return model;
  }
}
