mixin HomeScreenMixin {
  String getCoursesTitleByCount(int count) => count == 1 ? 'Curso' : 'Cursos';
  String getStudentsTitleByCount(int count) =>
      count == 1 ? 'Estudante' : 'Estudantes';
}
