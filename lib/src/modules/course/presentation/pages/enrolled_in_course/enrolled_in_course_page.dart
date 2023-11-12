import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school_app/src/modules/course/data/model/get_course_by_id_model.dart';
import 'package:school_app/src/modules/course/presentation/stores/course_register/course_register_store.dart';
import 'package:school_app/src/shared/presentation/utils/toast.dart';
import 'package:school_app/src/shared/presentation/widgets/content_box.dart';
import 'package:school_app/src/shared/presentation/widgets/delete_item_dialog.dart';
import 'package:school_app/src/shared/presentation/widgets/empty_state_widget.dart';
import 'package:school_app/src/shared/presentation/widgets/school_app_bar.dart';

class EnrolledInCoursePage extends StatefulWidget {
  final int courseId;
  final List<CourseStudents> students;
  const EnrolledInCoursePage({
    super.key,
    required this.courseId,
    required this.students,
  });

  @override
  State<EnrolledInCoursePage> createState() => _EnrolledInCoursePageState();
}

class _EnrolledInCoursePageState extends State<EnrolledInCoursePage> {
  final store = Modular.get<CourseRegisterStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SchoolAppBar(
        title: Text('Alunos matriculados'),
      ),
      body: widget.students.isEmpty
          ? EmptyStateWidget(
              message: "Nenhum aluno matriculado",
              buttonText: "Voltar",
              buttonOnTap: () {
                Modular.to.pop();
              },
            )
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) {
                final student = widget.students[index];
                final formattedDate = student.birthDate
                    .toString()
                    .split(' ')[0]
                    .split('-')
                    .reversed
                    .join('/');
                return ContentBox(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Nome: ${student.name}"),
                            Text("Data de nascimento: $formattedDate"),
                          ],
                        ),
                        GestureDetector(
                          onTap: () async {
                            final result = await showDialog<bool?>(
                              context: context,
                              builder: (context) => const DeleteItemDialog(
                                message:
                                    "Deseja realmente excluir a matrícula?",
                              ),
                            );

                            if (result == null) return;

                            if (result) {
                              store.deleteEnrollment(student.enrollmentId).then(
                                (success) {
                                  if (success) {
                                    widget.students.removeAt(index);
                                    setState(() {});
                                    Toast().show(
                                      context,
                                      text: "Matrícula removida com sucesso",
                                      status: ToastStatus.success,
                                    );
                                  } else {
                                    Toast().show(
                                      context,
                                      text: "Erro ao remover matrícula",
                                      status: ToastStatus.error,
                                    );
                                  }
                                },
                              );
                            }
                          },
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
              },
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemCount: widget.students.length,
            ),
    );
  }
}
