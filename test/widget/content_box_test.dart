import 'package:flutter_test/flutter_test.dart';
import 'package:school_app/src/shared/presentation/widgets/content_box.dart';

import '../helpers/test_app_widget.dart';

void main() {
  testWidgets(
    "WHEN tap ContentBox THEN ensure onTap was called",
    (tester) async {
      int timesOnTapCalled = 0;

      await tester.pumpWidget(
        TestAppWidget(
          child: ContentBox(
            onTap: () => timesOnTapCalled++,
            children: const [],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(timesOnTapCalled, 0);

      await tester.tap(find.byType(ContentBox));
      await tester.pumpAndSettle();

      expect(timesOnTapCalled, 1);
    },
  );
}
