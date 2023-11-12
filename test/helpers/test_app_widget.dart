import 'package:flutter/material.dart';
import 'package:school_app/src/shared/presentation/widgets/school_app_bar.dart';

class TestAppWidget extends StatelessWidget {
  final Widget child;
  const TestAppWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: const SchoolAppBar(
          title: Text(''),
        ),
        body: Center(child: child),
      ),
    );
  }
}
