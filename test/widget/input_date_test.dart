import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_app/src/shared/presentation/widgets/input_date.dart';

import '../helpers/test_app_widget.dart';

void main() {
  testWidgets(
    "WHEN load InputDate and enter value THEN ensure controller text is formatted",
    (tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(
        TestAppWidget(
          child: InputDate(
            controller: controller,
            label: "Date",
          ),
        ),
      );

      await tester.pumpAndSettle();

      await tester.enterText(find.byType(InputDate), "12052004");

      await tester.pumpAndSettle();

      expect(controller.text, "12/05/2004");
    },
  );
}
