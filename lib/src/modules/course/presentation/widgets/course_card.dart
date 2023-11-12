import 'package:flutter/material.dart';
import 'package:school_app/src/modules/course/data/model/get_all_courses_model.dart';
import 'package:school_app/src/shared/presentation/widgets/content_box.dart';

class CourseCard extends StatelessWidget {
  final CourseModel course;
  final void Function(CourseModel) onDelete;
  final void Function(int id) onTap;
  const CourseCard({
    Key? key,
    required this.course,
    required this.onDelete,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContentBox(
      onTap: () {
        onTap(course.id);
      },
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                course.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                onDelete(course);
              },
              child: Icon(
                Icons.delete,
                color: Colors.grey.shade700,
                size: 20,
              ),
            )
          ],
        ),
        if (course.description != null && course.description!.isNotEmpty) ...[
          const SizedBox(height: 4),
          Flexible(
            child: Text(
              "${course.description}",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade900,
              ),
            ),
          ),
        ],
        const SizedBox(height: 4),
        Flexible(
          child: Text(
            "${course.enrolledStudentsCount} alunos matriculados - ${course.maxEnrollments - course.enrolledStudentsCount} vagas",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade800,
            ),
          ),
        ),
      ],
    );
  }
}
