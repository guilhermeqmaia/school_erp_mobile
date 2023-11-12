import 'package:flutter/material.dart';
import 'package:school_app/src/modules/course/data/model/get_all_courses_model.dart';
import 'package:school_app/src/modules/course/presentation/stores/courses_listing/courses_listing_state.dart';
import 'package:school_app/src/modules/course/presentation/widgets/course_card.dart';
import 'package:school_app/src/shared/presentation/widgets/empty_state_widget.dart';

class CoursesListingScreen extends StatelessWidget {
  final CoursesListingSuccess state;
  final void Function(CourseModel id) onDelete;
  final void Function(int id) onTap;

  ///It will be called when the page has an empty state and the user tap the button
  final VoidCallback onCreate;

  const CoursesListingScreen({
    Key? key,
    required this.state,
    required this.onDelete,
    required this.onTap,
    required this.onCreate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state.model.courses.isEmpty) {
      return EmptyStateWidget(
        message: "Nenhum curso encontrado",
        buttonText: "Adicionar curso",
        buttonOnTap: onCreate,
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemBuilder: (context, index) {
        final course = state.model.courses[index];
        return CourseCard(
          course: course,
          onDelete: onDelete,
          onTap: onTap,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemCount: state.model.courses.length,
    );
  }
}
