import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school_app/src/modules/course/data/entity/course.dart';
import 'package:school_app/src/modules/course/presentation/stores/create_course/create_course_state.dart';
import 'package:school_app/src/modules/course/presentation/stores/create_course/create_course_store.dart';
import 'package:school_app/src/shared/presentation/widgets/button.dart';
import 'package:school_app/src/shared/presentation/widgets/input.dart';
import 'package:school_app/src/shared/presentation/widgets/modal.dart';

class CreateCourseModal extends StatefulWidget {
  const CreateCourseModal({Key? key}) : super(key: key);

  @override
  State<CreateCourseModal> createState() => _CreateCourseModalState();
}

class _CreateCourseModalState extends State<CreateCourseModal> {
  final store = Modular.get<CreateCourseStore>();
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final maxEnrollmentsController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    maxEnrollmentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateCourseStore, CreateCourseState>(
        bloc: store,
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: formKey,
              child: Modal(
                title: "Criar curso",
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
                        return "O valor deve ser um número";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  Button(
                    loading: state is CreateCourseLoading,
                    onPressed: () async {
                      final isValid = formKey.currentState!.validate();
                      if (!isValid) return;
                      final model = Course(
                        name: nameController.text,
                        description: descriptionController.text,
                        maxEnrollments:
                            int.parse(maxEnrollmentsController.text.trim()),
                      );
                      await store.create(model);
                      Modular.to.pop(store.state);
                    },
                    text: "Confirmar",
                  ),
                ],
              ),
            ),
          );
        });
  }
}
