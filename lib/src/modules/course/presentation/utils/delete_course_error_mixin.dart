import 'package:school_app/src/modules/course/presentation/stores/delete_course/delete_course_state.dart';

mixin DeleteCourseErrorMixin {
  String getErrorMessage(DeleteCourseError error) {
    String message = "";
    if (error.message == "Course has students enrolled") {
      message = "Não é possível excluir um curso com alunos matriculados";
    } else {
      message = "Erro ao excluir curso";
    }
    return message;
  }
}
