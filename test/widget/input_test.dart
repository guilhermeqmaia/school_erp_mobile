import 'package:flutter_test/flutter_test.dart';
import 'package:school_app/src/shared/presentation/widgets/input.dart';

import '../helpers/test_app_widget.dart';

void main() {
  testWidgets(
    "WHEN load Input with Label THEN ensure it is enabled",
    (tester) async {
      await tester.pumpWidget(
        const TestAppWidget(
          child: Input(
            label: "MockLabel",
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text("MockLabel"), findsOneWidget);
    },
  );
  testWidgets(
    "WHEN load Input and enter invalid value THEN ensure validator show message",
    (tester) async {
      await tester.pumpWidget(
        TestAppWidget(
          child: Input(
            label: "MockLabel",
            validator: (value) {
              if (value != null) return "InvalidInput";
              return null;
            },
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.enterText(find.byType(Input), "AnyText");

      await tester.pumpAndSettle();
      expect(find.text("InvalidInput"), findsOneWidget);
    },
  );

  testWidgets(
    "WHEN load Input and enter value THEN ensure onChanged was called",
    (tester) async {
      int inputValueLength = 0;
      await tester.pumpWidget(
        TestAppWidget(
          child: Input(
            onChanged: (value) {
              inputValueLength = value.length;
            },
          ),
        ),
      );

      expect(inputValueLength, 0);

      await tester.pumpAndSettle();
      await tester.enterText(find.byType(Input), "AnyText");

      await tester.pumpAndSettle();
      expect(inputValueLength, 7);
    },
  );
}
