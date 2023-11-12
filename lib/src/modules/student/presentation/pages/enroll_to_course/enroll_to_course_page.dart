import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school_app/src/modules/student/presentation/store/enroll_to_course/enroll_to_course_state.dart';
import 'package:school_app/src/modules/student/presentation/store/enroll_to_course/enroll_to_course_store.dart';
import 'package:school_app/src/shared/presentation/screens/error_screen.dart';
import 'package:school_app/src/shared/presentation/screens/loading_screen.dart';
import 'package:school_app/src/shared/presentation/utils/toast.dart';
import 'package:school_app/src/shared/presentation/widgets/content_box.dart';
import 'package:school_app/src/shared/presentation/widgets/empty_state_widget.dart';
import 'package:school_app/src/shared/presentation/widgets/school_app_bar.dart';

class EnrollToCoursePage extends StatefulWidget {
  final int studentId;
  const EnrollToCoursePage({
    super.key,
    required this.studentId,
  });

  @override
  State<EnrollToCoursePage> createState() => _EnrollToCoursePageState();
}

class _EnrollToCoursePageState extends State<EnrollToCoursePage> {
  final store = Modular.get<EnrollToCourseStore>();

  void _handleEnrollResult(EnrollInCourseResponseEnum response) {
    switch (response) {
      case EnrollInCourseResponseEnum.success:
        Toast().show(
          context,
          text: "Matrícula realizada com sucesso!",
          status: ToastStatus.success,
        );
        break;
      case EnrollInCourseResponseEnum.enrollmentLimitReached:
        Toast().show(
          context,
          text: "O limite de matrículas foi atingido",
          status: ToastStatus.error,
        );
        break;
      case EnrollInCourseResponseEnum.error:
        Toast().show(
          context,
          text: "Erro ao realizar matrícula",
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
        title: Text('Matricular em um curso'),
      ),
      body: BlocBuilder<EnrollToCourseStore, EnrollToCourseState>(
        bloc: store,
        builder: (context, state) {
          if (state is EnrollToCourseLoading) return const LoadingScreen();
          if (state is EnrollToCourseError) {
            return ErrorScreen(onRetry: store.fetch);
          }
          if (state is EnrollToCourseSuccess) {
            if (state.model.courses.isEmpty) {
              return EmptyStateWidget(
                message: "Nenhum curso cadastrado",
                buttonText: "Cadastrar curso",
                buttonOnTap: () {
                  Modular.to.pushNamed("/course/").then((_) => store.fetch());
                },
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: state.model.courses.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final item = state.model.courses[index];

                return ContentBox(
                  onTap: () {
                    store.enroll(item.id, widget.studentId).then((response) {
                      _handleEnrollResult(response);
                      Modular.to
                          .pop(response != EnrollInCourseResponseEnum.error);
                    });
                  },
                  children: [Text(item.name)],
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
