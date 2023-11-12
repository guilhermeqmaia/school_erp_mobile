import 'package:flutter/material.dart';
import 'package:school_app/src/modules/student/data/model/get_all_students_model.dart';
import 'package:school_app/src/shared/presentation/widgets/content_box.dart';

class StudentCard extends StatelessWidget {
  final StudentModel item;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  const StudentCard({
    super.key,
    required this.item,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ContentBox(
      onTap: onTap,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Data de nascimento: ${item.formattedDate}",
                  style: const TextStyle(fontSize: 14),
                ),
                if (item.courseName != null)
                  Text(
                    "Curso: ${item.courseName}",
                    style: const TextStyle(fontSize: 14),
                  )
              ],
            ),
            GestureDetector(
              onTap: onDelete,
              child: Icon(
                Icons.delete,
                color: Colors.grey.shade700,
                size: 20,
              ),
            )
          ],
        ),
      ],
    );
  }
}
