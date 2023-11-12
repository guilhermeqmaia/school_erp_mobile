import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school_app/src/modules/home/presentation/pages/screens/home_screen.dart';
import 'package:school_app/src/modules/home/presentation/stores/home_state.dart';
import 'package:school_app/src/modules/home/presentation/stores/home_store.dart';
import 'package:school_app/src/shared/presentation/screens/error_screen.dart';
import 'package:school_app/src/shared/presentation/screens/loading_screen.dart';
import 'package:school_app/src/shared/presentation/widgets/school_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final store = Modular.get<HomeStore>();
  @override
  void initState() {
    store.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SchoolAppBar(
        title: Text('Home'),
      ),
      body: BlocBuilder<HomeStore, HomeState>(
        bloc: store,
        builder: (context, state) {
          if (state is HomeLoading) return const LoadingScreen();
          if (state is HomeError) return ErrorScreen(onRetry: store.fetch);
          if (state is HomeSuccess) {
            return HomeScreen(
              state: state,
              onRefresh: () async => store.fetch(),
            );
          }
          return const SizedBox();
        },
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        child: Text(
          "Desenvolvido por @guilhermeqmaia",
          style: TextStyle(color: Colors.grey.shade700),
        ),
      ),
    );
  }
}
