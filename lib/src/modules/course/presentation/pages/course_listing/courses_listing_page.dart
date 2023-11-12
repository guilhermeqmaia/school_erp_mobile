import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school_app/src/modules/course/presentation/pages/course_listing/create_course_modal.dart';
import 'package:school_app/src/modules/course/presentation/pages/course_listing/screens/courses_listing_screen.dart';
import 'package:school_app/src/modules/course/presentation/stores/courses_listing/courses_listing_state.dart';
import 'package:school_app/src/modules/course/presentation/stores/courses_listing/courses_listing_store.dart';
import 'package:school_app/src/modules/course/presentation/stores/create_course/create_course_state.dart';
import 'package:school_app/src/modules/course/presentation/stores/delete_course/delete_course_state.dart';
import 'package:school_app/src/modules/course/presentation/stores/delete_course/delete_course_store.dart';
import 'package:school_app/src/modules/course/presentation/utils/delete_course_error_mixin.dart';
import 'package:school_app/src/shared/presentation/screens/error_screen.dart';
import 'package:school_app/src/shared/presentation/screens/loading_screen.dart';
import 'package:school_app/src/shared/presentation/utils/toast.dart';
import 'package:school_app/src/shared/presentation/widgets/delete_item_dialog.dart';
import 'package:school_app/src/shared/presentation/widgets/school_app_bar.dart';

class CoursesListingPage extends StatefulWidget {
  const CoursesListingPage({super.key});

  @override
  State<CoursesListingPage> createState() => _CoursesListingPageState();
}

class _CoursesListingPageState extends State<CoursesListingPage>
    with DeleteCourseErrorMixin {
  final store = Modular.get<CoursesListingStore>();
  final deleteCourseStore = Modular.get<DeleteCourseStore>();

  @override
  void initState() {
    store.fetch();
    super.initState();
  }

  void _onDeleteCourseResponse(Object? response) {
    if (response == null) return;
    if (response is DeleteCourseSuccess) {
      store.fetch();

      Toast().show(
        context,
        text: "Curso excluído com sucesso",
        status: ToastStatus.success,
      );
    }
    if (response is DeleteCourseError) {
      final message = getErrorMessage(response);
      Toast().show(
        context,
        text: message,
        status: ToastStatus.error,
      );
    }
  }

  void _onCreateCourseResponse(Object? response) {
    if (response == null) return;
    if (response is CreateCourseSuccess) {
      store.fetch();

      Toast().show(
        context,
        text: "Curso criado com sucesso",
        status: ToastStatus.success,
      );
    } else {
      Toast().show(
        context,
        text: "Ocorreu um erro ao criar o curso",
        status: ToastStatus.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SchoolAppBar(
        title: Text('Cursos'),
      ),
      body: BlocBuilder<CoursesListingStore, CoursesListingState>(
        bloc: store,
        builder: (context, state) {
          if (state is CoursesListingLoading) return const LoadingScreen();
          if (state is CoursesListingError) {
            return ErrorScreen(onRetry: store.fetch);
          }
          if (state is CoursesListingSuccess) {
            return CoursesListingScreen(
              state: state,
              onDelete: (course) async {
                final result = await showDialog<bool?>(
                  context: context,
                  builder: (context) => const DeleteItemDialog(
                    message: "Deseja realmente excluir o curso?",
                  ),
                );

                if (result == null) return;

                if (result) {
                  deleteCourseStore.delete(course.id).then((_) {
                    final state = deleteCourseStore.state;
                    _onDeleteCourseResponse(state);
                  });
                }
              },
              onTap: (id) {
                Modular.to.pushNamed('/course/register?id=$id').then(
                      (_) => store.fetch(),
                    );
              },
              onCreate: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => const CreateCourseModal(),
                ).then(_onCreateCourseResponse);
              },
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => const CreateCourseModal(),
          ).then(_onCreateCourseResponse);
        },
        backgroundColor: Colors.orange.shade400,
        child: const Icon(Icons.add),
      ),
    );
  }
}
