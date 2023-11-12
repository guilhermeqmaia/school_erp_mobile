import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_app/src/shared/presentation/widgets/delete_item_dialog.dart';

void main() {
  testWidgets(
    "WHEN open DeleteItemDialog THEN tap to confirm",
    (tester) async {
      late Object? response;
      late BuildContext context;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (ctx) {
              context = ctx;
              return GestureDetector(
                onTap: () async {
                  response = await showDialog(
                    context: context,
                    builder: (context) =>
                        const DeleteItemDialog(message: "MockMessage"),
                  );
                },
                child: const Text("Press Me"),
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text("Press Me"));

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("confirm_button")));
      await tester.pumpAndSettle();

      expect(response, true);
    },
  );
  testWidgets(
    "WHEN open DeleteItemDialog THEN tap to deny",
    (tester) async {
      late Object? response;
      late BuildContext context;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (ctx) {
              context = ctx;
              return GestureDetector(
                onTap: () async {
                  response = await showDialog(
                    context: context,
                    builder: (context) =>
                        const DeleteItemDialog(message: "MockMessage"),
                  );
                },
                child: const Text("Press Me"),
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text("Press Me"));

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("deny_button")));
      await tester.pumpAndSettle();

      expect(response, false);
    },
  );
  testWidgets(
    "WHEN open DeleteItemDialog THEN pop and response is null",
    (tester) async {
      late Object? response;
      late BuildContext context;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (ctx) {
              context = ctx;
              return GestureDetector(
                key: const Key("btn_open"),
                onTap: () async {
                  response = await showDialog(
                    context: context,
                    builder: (context) =>
                        const DeleteItemDialog(message: "MockMessage"),
                  );
                },
                child: const Text("Press Me"),
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text("Press Me"));

      await tester.pumpAndSettle();
      Navigator.pop(context);
      await tester.pumpAndSettle();

      expect(response, null);
    },
  );
}
