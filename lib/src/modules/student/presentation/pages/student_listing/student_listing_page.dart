import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school_app/src/modules/student/presentation/pages/student_listing/create_student_modal.dart';
import 'package:school_app/src/modules/student/presentation/store/student_listing/student_listing_state.dart';
import 'package:school_app/src/modules/student/presentation/store/student_listing/student_listing_store.dart';
import 'package:school_app/src/modules/student/presentation/utils/delete_item_response_enum.dart';
import 'package:school_app/src/modules/student/presentation/widgets/student_card.dart';
import 'package:school_app/src/shared/presentation/screens/error_screen.dart';
import 'package:school_app/src/shared/presentation/screens/loading_screen.dart';
import 'package:school_app/src/shared/presentation/utils/toast.dart';
import 'package:school_app/src/shared/presentation/widgets/delete_item_dialog.dart';
import 'package:school_app/src/shared/presentation/widgets/empty_state_widget.dart';
import 'package:school_app/src/shared/presentation/widgets/school_app_bar.dart';

class StudentListingPage extends StatefulWidget {
  const StudentListingPage({super.key});

  @override
  State<StudentListingPage> createState() => _StudentListingPageState();
}

class _StudentListingPageState extends State<StudentListingPage> {
  final store = Modular.get<StudentListingStore>();

  void _handleDeleteItemResponse(DeleteItemResponseEnum response) {
    switch (response) {
      case DeleteItemResponseEnum.sucess:
        Toast().show(
          context,
          text: "Estudante removido com sucesso",
          status: ToastStatus.success,
        );
        break;
      case DeleteItemResponseEnum.studentHasEnrollments:
        Toast().show(
          context,
          text: "Não é possível remover estudante matriculado em algum curso",
          status: ToastStatus.error,
        );
        break;
      case DeleteItemResponseEnum.error:
        Toast().show(
          context,
          text: "Erro ao remover estudante",
          status: ToastStatus.error,
        );
        break;
    }
  }

  void _handleCreateResult(bool? result) {
    if (result == null) return;
    if (result) {
      Toast().show(
        context,
        text: "Estudante criado com sucesso!",
        status: ToastStatus.success,
      );
      store.fetch();
    } else {
      Toast().show(
        context,
        text: "Erro ao criar estudante",
        status: ToastStatus.error,
      );
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
        title: Text('Estudantes'),
      ),
      body: BlocBuilder<StudentListingStore, StudentListingState>(
        builder: (context, state) {
          if (state is StudentListingLoading) return const LoadingScreen();
          if (state is StudentListingError) {
            return ErrorScreen(onRetry: store.fetch);
          }
          if (state is StudentListingSuccess) {
            if (state.model.students.isEmpty) {
              return EmptyStateWidget(
                message: "Nenhum estudante cadastrado",
                buttonText: "Cadastrar estudante",
                buttonOnTap: () {
                  showModalBottomSheet<bool?>(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => const CreateStudentModal(),
                  ).then((result) {
                    if (result == null) return;
                    _handleCreateResult(result);
                  });
                },
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 80),
              itemCount: state.model.students.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = state.model.students[index];

                return StudentCard(
                  item: item,
                  onTap: () {
                    Modular.to
                        .pushNamed('/student/register?id=${item.id}')
                        .then((_) => store.fetch());
                  },
                  onDelete: () async {
                    final result = await showDialog<bool?>(
                      context: context,
                      builder: (context) => const DeleteItemDialog(
                        message: "Deseja remover o estudante?",
                      ),
                    );

                    if (result == null) return;

                    if (result) {
                      store.deleteItem(item.id).then(_handleDeleteItemResponse);
                    }
                  },
                );
              },
            );
          }

          return Container();
        },
        bloc: store,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<bool?>(
            context: context,
            isScrollControlled: true,
            builder: (context) => const CreateStudentModal(),
          ).then((result) {
            if (result == null) return;
            _handleCreateResult(result);
          });
        },
        backgroundColor: Colors.orange.shade400,
        child: const Icon(Icons.add),
      ),
    );
  }
}
