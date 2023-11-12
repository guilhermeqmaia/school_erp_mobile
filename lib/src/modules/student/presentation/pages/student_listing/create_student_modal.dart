import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school_app/src/modules/student/data/entity/student.dart';
import 'package:school_app/src/modules/student/presentation/store/create_student/create_student_state.dart';
import 'package:school_app/src/modules/student/presentation/store/create_student/create_student_store.dart';
import 'package:school_app/src/shared/presentation/utils/birth_date_validator.dart';
import 'package:school_app/src/shared/presentation/utils/format_date.dart';
import 'package:school_app/src/shared/presentation/widgets/button.dart';
import 'package:school_app/src/shared/presentation/widgets/input.dart';
import 'package:school_app/src/shared/presentation/widgets/input_date.dart';
import 'package:school_app/src/shared/presentation/widgets/modal.dart';

class CreateStudentModal extends StatefulWidget {
  const CreateStudentModal({super.key});

  @override
  State<CreateStudentModal> createState() => _CreateStudentModalState();
}

class _CreateStudentModalState extends State<CreateStudentModal> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final birthDateController = TextEditingController();
  final store = Modular.get<CreateStudentStore>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateStudentStore, CreateStudentState>(
        bloc: store,
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Modal(
                title: "Criar estudante",
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
                  const SizedBox(height: 8),
                  Button(
                    onPressed: () {
                      final isValid = formKey.currentState!.validate();
                      if (!isValid) return;
                      final model = Student(
                        name: nameController.text,
                        birthDate: FormatDate.format(birthDateController.text),
                      );

                      store.create(model).then(
                            (_) => Modular.to
                                .pop(store.state is CreateStudentSuccess),
                          );
                    },
                    text: "Confirmar",
                    loading: store.state is CreateStudentLoading,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
