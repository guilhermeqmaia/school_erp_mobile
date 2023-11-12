import 'package:flutter/material.dart';
import 'package:school_app/src/modules/course/presentation/stores/course_register/course_register_state.dart';
import 'package:school_app/src/shared/presentation/widgets/input.dart';

class CourseRegisterScreen extends StatefulWidget {
  final CourseRegisterSuccess state;
  final GlobalKey<FormState> formKey;
  const CourseRegisterScreen({
    Key? key,
    required this.state,
    required this.formKey,
  }) : super(key: key);

  @override
  State<CourseRegisterScreen> createState() => _CourseRegisterScreenState();
}

class _CourseRegisterScreenState extends State<CourseRegisterScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final maxEnrollmentsController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.state.model.name;
    descriptionController.text = widget.state.model.description ?? "";
    maxEnrollmentsController.text =
        widget.state.model.maxEnrollments.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: widget.formKey,
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
                return null;
              },
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
