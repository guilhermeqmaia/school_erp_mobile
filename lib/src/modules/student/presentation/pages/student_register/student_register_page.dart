import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school_app/src/modules/student/data/entity/student.dart';
import 'package:school_app/src/modules/student/presentation/store/student_register/student_register_state.dart';
import 'package:school_app/src/modules/student/presentation/store/student_register/student_register_store.dart';
import 'package:school_app/src/shared/presentation/screens/error_screen.dart';
import 'package:school_app/src/shared/presentation/screens/loading_screen.dart';
import 'package:school_app/src/shared/presentation/utils/birth_date_validator.dart';
import 'package:school_app/src/shared/presentation/utils/format_date.dart';
import 'package:school_app/src/shared/presentation/utils/toast.dart';
import 'package:school_app/src/shared/presentation/widgets/button.dart';
import 'package:school_app/src/shared/presentation/widgets/content_box.dart';
import 'package:school_app/src/shared/presentation/widgets/delete_item_dialog.dart';
import 'package:school_app/src/shared/presentation/widgets/input.dart';
import 'package:school_app/src/shared/presentation/widgets/input_date.dart';
import 'package:school_app/src/shared/presentation/widgets/school_app_bar.dart';

class StudentRegisterPage extends StatefulWidget {
  final int studentId;
  const StudentRegisterPage({
    super.key,
    required this.studentId,
  });

  @override
  State<StudentRegisterPage> createState() => _StudentRegisterPageState();
}

class _StudentRegisterPageState extends State<StudentRegisterPage> {
  final store = Modular.get<StudentRegisterStore>();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final birthDateController = TextEditingController();

  void fillControllers(StudentRegisterSuccess state) {
    nameController.text = state.model.name;
    final birthDate = state.model.birthDate;
    birthDateController.text =
        "${birthDate.day}/${birthDate.month}/${birthDate.year}";
  }

  void _handleDeleteEnrollmentResult(bool success) {
    if (success) {
      Toast().show(
        context,
        text: "Matrícula removida com sucesso!",
        status: ToastStatus.success,
      );
      store.fetch(widget.studentId);
    } else {
      Toast().show(
        context,
        text: "Erro ao remover matrícula",
        status: ToastStatus.error,
      );
    }
  }

  @override
  void initState() {
    store.fetch(widget.studentId);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SchoolAppBar(
        title: Text('Estudante'),
      ),
      body: BlocConsumer<StudentRegisterStore, StudentRegisterState>(
        bloc: store,
        listener: (context, state) {
          if (state is StudentRegisterSuccess) fillControllers(state);
        },
        builder: (context, state) {
          if (state is StudentRegisterLoading) return const LoadingScreen();
          if (state is StudentRegisterError) {
            return ErrorScreen(onRetry: () => store.fetch(widget.studentId));
          }
          if (state is StudentRegisterSuccess) {
            return Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
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
                    InputDate(
                      controller: birthDateController,
                      label: "Data de nascimento*",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Campo obrigatório";
                        }
                        return BirthDateValidator.validate(value);
                      },
                    ),
                    if (state.model.enrollmentId != null) ...[
                      const SizedBox(height: 8),
                      ContentBox(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Matrículado no curso: ${state.model.courseName}",
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final result = await showDialog<bool?>(
                                    context: context,
                                    builder: (context) =>
                                        const DeleteItemDialog(
                                      message: "Deseja remover a matrícula?",
                                    ),
                                  );

                                  if (result == null) return;

                                  if (result) {
                                    store
                                        .deleteEnrollment(
                                            state.model.enrollmentId!)
                                        .then(_handleDeleteEnrollmentResult);
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
                      ),
                    ] else ...[
                      const SizedBox(height: 8),
                      Button(
                        onPressed: () async {
                          Modular.to
                              .pushNamed(
                                  '/student/register/enroll?id=${widget.studentId}')
                              .then(
                            (result) {
                              store.fetch(widget.studentId);
                            },
                          );
                        },
                        text: "Matricular em um curso",
                        type: ButtonType.secondary,
                      ),
                    ],
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
      bottomSheet: BlocBuilder<StudentRegisterStore, StudentRegisterState>(
        bloc: store,
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: Button(
              onPressed: () {
                final isValid = formKey.currentState!.validate();
                if (!isValid) return;
                final model = Student(
                  id: widget.studentId,
                  name: nameController.text,
                  birthDate: FormatDate.format(birthDateController.text),
                );

                store.save(model).then((_) => Modular.to.pop());
              },
              text: "Salvar",
            ),
          );
        },
      ),
    );
  }
}
