import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school_app/src/modules/course/data/model/get_not_enrolled_students_model.dart';
import 'package:school_app/src/modules/course/presentation/stores/enroll_in_course/enroll_in_course_state.dart';
import 'package:school_app/src/modules/course/presentation/stores/enroll_in_course/enroll_in_course_store.dart';
import 'package:school_app/src/shared/presentation/screens/error_screen.dart';
import 'package:school_app/src/shared/presentation/screens/loading_screen.dart';
import 'package:school_app/src/shared/presentation/utils/toast.dart';
import 'package:school_app/src/shared/presentation/widgets/button.dart';
import 'package:school_app/src/shared/presentation/widgets/content_box.dart';
import 'package:school_app/src/shared/presentation/widgets/empty_state_widget.dart';
import 'package:school_app/src/shared/presentation/widgets/school_app_bar.dart';

class EnrollInCoursePage extends StatefulWidget {
  final int courseId;
  final int availableEnrollments;
  const EnrollInCoursePage({
    super.key,
    required this.courseId,
    required this.availableEnrollments,
  });

  @override
  State<EnrollInCoursePage> createState() => _EnrollInCoursePageState();
}

class _EnrollInCoursePageState extends State<EnrollInCoursePage> {
  final store = Modular.get<EnrollInCourseStore>();

  List<StudentModel> selectedStudents = [];

  void _onSaveResult(EnrollInCourseResponseEnum response) async {
    switch (response) {
      case EnrollInCourseResponseEnum.success:
        Toast().show(
          super.context,
          text: "Alunos matriculados com sucesso",
          status: ToastStatus.success,
        );
        Modular.to.pop(true);
        break;
      case EnrollInCourseResponseEnum.enrollmentLimitReached:
        Toast().show(
          super.context,
          text: "O limite de matrículas foi atingido",
          status: ToastStatus.error,
        );
        Modular.to.pop(true);
        break;
      case EnrollInCourseResponseEnum.error:
        Toast().show(
          super.context,
          text: "Erro ao matricular alunos",
          status: ToastStatus.error,
        );
        break;
    }
  }

  @override
  void initState() {
    store.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SchoolAppBar(
        title: Text('Matricular alunos'),
      ),
      body: BlocBuilder<EnrollInCourseStore, EnrollInCourseState>(
        bloc: store,
        builder: (context, state) {
          if (state is EnrollInCourseLoading) return const LoadingScreen();
          if (state is EnrollInCourseError) {
            return ErrorScreen(onRetry: store.fetch);
          }
          if (state is EnrollInCourseSuccess) {
            if (state.model.students.isEmpty) {
              return EmptyStateWidget(
                message: "Nenhum aluno cadastrado",
                buttonText: "Cadastrar aluno",
                buttonOnTap: () {
                  Modular.to.pushNamed("/student/").then((_) => store.fetch());
                },
              );
            }
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ContentBox(
                    children: [
                      Text(
                        "Matrículas disponíveis: ${widget.availableEnrollments - selectedStudents.length}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final item = state.model.students[index];
                        final formattedDate = item.birthDate
                            .toString()
                            .split(' ')[0]
                            .split('-')
                            .reversed
                            .join('/');
                        return CheckboxListTile(
                          value: selectedStudents.contains(item),
                          onChanged: (value) {
                            final isFull = selectedStudents.length >=
                                widget.availableEnrollments;
                            if (isFull && value == true) {
                              Toast().show(
                                context,
                                text:
                                    "Não há mais matrículas disponíveis, remova um aluno para adicionar outro",
                                status: ToastStatus.warning,
                              );
                              return;
                            }
                            setState(() {
                              if (value == true) {
                                selectedStudents.add(item);
                              } else {
                                selectedStudents.remove(item);
                              }
                            });
                          },
                          title: Text(item.name),
                          subtitle: Text(formattedDate),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemCount: state.model.students.length,
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
      bottomSheet: BlocBuilder<EnrollInCourseStore, EnrollInCourseState>(
        bloc: store,
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: Button(
              onPressed: () async {
                store
                    .enroll(selectedStudents, widget.courseId)
                    .then((response) {
                  _onSaveResult(response);
                });
              },
              text: "Matricular",
              loading: state is EnrollInCourseLoading,
              enabled:
                  state is! EnrollInCourseError && selectedStudents.isNotEmpty,
            ),
          );
        },
      ),
    );
  }
}
