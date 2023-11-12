import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school_app/src/modules/course/data/entity/course.dart';
import 'package:school_app/src/modules/course/presentation/stores/course_register/course_register_state.dart';
import 'package:school_app/src/modules/course/presentation/stores/course_register/course_register_store.dart';
import 'package:school_app/src/shared/presentation/screens/error_screen.dart';
import 'package:school_app/src/shared/presentation/screens/loading_screen.dart';
import 'package:school_app/src/shared/presentation/utils/toast.dart';
import 'package:school_app/src/shared/presentation/widgets/button.dart';
import 'package:school_app/src/shared/presentation/widgets/input.dart';
import 'package:school_app/src/shared/presentation/widgets/school_app_bar.dart';

class CourseRegisterPage extends StatefulWidget {
  final int courseId;
  const CourseRegisterPage({
    Key? key,
    required this.courseId,
  }) : super(key: key);

  @override
  State<CourseRegisterPage> createState() => _CourseRegisterPageState();
}

class _CourseRegisterPageState extends State<CourseRegisterPage> {
  final store = Modular.get<CourseRegisterStore>();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final maxEnrollmentsController = TextEditingController();

  void fillControllers(CourseRegisterSuccess state) {
    nameController.text = state.model.name;
    descriptionController.text = state.model.description ?? "";
    maxEnrollmentsController.text = state.model.maxEnrollments.toString();
  }

  void _onSaveResult(bool success) {
    if (success) {
      Toast().show(
        context,
        text: "Curso atualizado com sucesso!",
        status: ToastStatus.success,
      );
      Modular.to.pop();
    } else {
      Toast().show(
        context,
        text: "Erro ao atualizar curso",
        status: ToastStatus.error,
      );
    }
  }

  @override
  void initState() {
    store.fetch(widget.courseId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const SchoolAppBar(title: Text('Curso')),
      body: BlocConsumer<CourseRegisterStore, CourseRegisterState>(
        bloc: store,
        listener: (context, state) {
          if (state is CourseRegisterSuccess) fillControllers(state);
        },
        builder: (context, state) {
          if (state is CourseRegisterLoading) return const LoadingScreen();
          if (state is CourseRegisterError) {
            return ErrorScreen(
              onRetry: () => store.fetch(widget.courseId),
            );
          }
          if (state is CourseRegisterSuccess) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Input(
                      controller: nameController,
                      label: "Nome*",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Campo obrigatório";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    Input(
                      controller: descriptionController,
                      label: "Descrição",
                    ),
                    const SizedBox(height: 8),
                    Input(
                      controller: maxEnrollmentsController,
                      label: "Máximo de matrículas*",
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Campo obrigatório";
                        }
                        if (int.tryParse(value) == null) {
                          return "Insira um número válido";
                        }
                        final total = int.parse(value);
                        if (total - state.model.students.length < 0) {
                          return "O número de matrículas deve ser maior ou igual ao número de alunos matriculados";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Button(
                            onPressed: () async {
                              final isValid = formKey.currentState!.validate();
                              if (!isValid) return;

                              final course = Course(
                                id: widget.courseId,
                                name: nameController.text,
                                description: descriptionController.text,
                                maxEnrollments:
                                    int.parse(maxEnrollmentsController.text),
                              );

                              final result = await store.save(course);

                              if (result) {
                                Modular.to.pushNamed(
                                  '/course/register/enrolled?id=${course.id}',
                                  arguments: {
                                    "students": state.model.students,
                                  },
                                ).then((_) => store.fetch(widget.courseId));
                              } else {
                                Toast().show(
                                  super.context,
                                  text: "Revise os campos para continuar",
                                  status: ToastStatus.error,
                                );
                              }
                            },
                            text: "Alunos matriculados",
                            type: ButtonType.secondary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Button(
                            onPressed: () async {
                              final isValid = formKey.currentState!.validate();
                              if (!isValid) return;

                              final course = Course(
                                id: widget.courseId,
                                name: nameController.text,
                                description: descriptionController.text,
                                maxEnrollments:
                                    int.parse(maxEnrollmentsController.text),
                              );

                              final result = await store.save(course);

                              if (result) {
                                final shouldRefresh =
                                    await Modular.to.pushNamed(
                                  '/course/register/enroll?id=${course.id}&availableEnrollments=${course.maxEnrollments! - state.model.students.length}',
                                );
                                if (shouldRefresh != null &&
                                    shouldRefresh is bool) {
                                  if (shouldRefresh) {
                                    store.fetch(widget.courseId);
                                  }
                                }
                              } else {
                                Toast().show(
                                  super.context,
                                  text: "Revise os campos para continuar",
                                  status: ToastStatus.error,
                                );
                              }
                            },
                            text: "Matricular alunos",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
      bottomSheet: BlocBuilder(
          bloc: store,
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Button(
                onPressed: () async {
                  final isValid = formKey.currentState!.validate();
                  if (!isValid) return;
                  final model = Course(
                    id: widget.courseId,
                    name: nameController.text,
                    description: descriptionController.text,
                    maxEnrollments: int.parse(maxEnrollmentsController.text),
                  );

                  final result = await store.save(model);

                  _onSaveResult(result);
                },
                enabled: store.state is! CourseRegisterError,
                text: "Salvar",
                loading: store.state is CourseRegisterLoading,
              ),
            );
          }),
    );
  }
}
