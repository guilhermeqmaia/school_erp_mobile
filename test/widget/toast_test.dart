import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_app/src/shared/presentation/utils/toast.dart';

void main() {
  final toast = Toast();

  testWidgets(
    "WHEN show success Toast THEN look for colors and text",
    (tester) async {
      late BuildContext context;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (ctx) {
              context = ctx;
              return const Scaffold(
                body: Center(
                  child: Text("App"),
                ),
              );
            },
          ),
        ),
      );

      toast.show(context, text: "Toast", status: ToastStatus.success);

      await tester.pumpAndSettle();
      await tester.pumpAndSettle();

      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));

      expect(find.text("Toast"), findsOneWidget);
      expect(snackBar.backgroundColor, Colors.green.shade700);
      expect(snackBar.content.key, const Key("Toast"));
    },
  );
  testWidgets(
    "WHEN show error Toast THEN look for colors and text",
    (tester) async {
      late BuildContext context;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (ctx) {
              context = ctx;
              return const Scaffold(
                body: Center(
                  child: Text("App"),
                ),
              );
            },
          ),
        ),
      );

      toast.show(context, text: "Toast", status: ToastStatus.error);

      await tester.pumpAndSettle();
      await tester.pumpAndSettle();

      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));

      expect(find.text("Toast"), findsOneWidget);
      expect(snackBar.backgroundColor, Colors.red.shade700);
      expect(snackBar.content.key, const Key("Toast"));
    },
  );
  testWidgets(
    "WHEN show warning Toast THEN look for colors and text",
    (tester) async {
      late BuildContext context;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (ctx) {
              context = ctx;
              return const Scaffold(
                body: Center(
                  child: Text("App"),
                ),
              );
            },
          ),
        ),
      );

      toast.show(context, text: "Toast", status: ToastStatus.warning);

      await tester.pumpAndSettle();
      await tester.pumpAndSettle();

      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));

      expect(find.text("Toast"), findsOneWidget);
      expect(snackBar.backgroundColor, Colors.yellow.shade700);
      expect(snackBar.content.key, const Key("Toast"));
    },
  );
}
