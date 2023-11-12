import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school_app/src/modules/home/presentation/stores/home_state.dart';
import 'package:school_app/src/modules/home/presentation/utils/home_screen_mixin.dart';
import 'package:school_app/src/modules/home/presentation/widgets/counter_box.dart';
import 'package:school_app/src/shared/presentation/widgets/layout_widget.dart';

class HomeScreen extends StatelessWidget with HomeScreenMixin {
  final HomeSuccess state;
  final Future<void> Function() onRefresh;
  const HomeScreen({
    super.key,
    required this.state,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      refresh: true,
      onRefresh: onRefresh,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CounterBox(
            icon: Icons.school,
            titleCount: state.model.courses.coursesCount,
            title: getCoursesTitleByCount(state.model.courses.coursesCount),
            subtitleCount: state.model.courses.enrollmentsCount,
            subtitle: "matrículas nos cursos",
            onTap: () {
              Modular.to.pushNamed('/course/').then((_) => onRefresh());
            },
          ),
          const SizedBox(height: 12),
          CounterBox(
            icon: Icons.library_books,
            titleCount: state.model.students.studentsCount,
            title: getStudentsTitleByCount(state.model.students.studentsCount),
            subtitleCount: state.model.students.enrollmentsCount,
            subtitle: "alunos matriculados em cursos",
            onTap: () {
              Modular.to.pushNamed('/student/').then((_) => onRefresh());
            },
          ),
        ],
      ),
    );
  }
}
