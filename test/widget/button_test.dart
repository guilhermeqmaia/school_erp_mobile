import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_app/src/shared/presentation/widgets/button.dart';

import '../helpers/test_app_widget.dart';

class _ButtonTestClass with ButtonMixin {}

void main() {
  final mixin = _ButtonTestClass();

  testWidgets(
    "WHEN button is loading THEN onPressed should not be called",
    (tester) async {
      int timesOnPressedWasCalled = 0;
      await tester.pumpWidget(
        TestAppWidget(
          child: Button(
            onPressed: () {
              timesOnPressedWasCalled++;
            },
            text: "Press Me",
            loading: true,
          ),
        ),
      );

      await tester.pump();

      expect(timesOnPressedWasCalled, 0);

      await tester.tap(find.byType(Button));
      await tester.pump();

      expect(timesOnPressedWasCalled, 0);
    },
  );

  testWidgets(
    "WHEN button is not enabled THEN onPressed should not be called",
    (tester) async {
      int timesOnPressedWasCalled = 0;
      await tester.pumpWidget(
        TestAppWidget(
          child: Button(
            onPressed: () {
              timesOnPressedWasCalled++;
            },
            text: "Press Me",
            enabled: false,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(timesOnPressedWasCalled, 0);

      await tester.tap(find.byType(Button));
      await tester.pumpAndSettle();

      expect(timesOnPressedWasCalled, 0);
    },
  );
  testWidgets(
    "WHEN button is enabled and not loading THEN onPressed should be called",
    (tester) async {
      int timesOnPressedWasCalled = 0;
      await tester.pumpWidget(
        TestAppWidget(
          child: Button(
            onPressed: () {
              timesOnPressedWasCalled++;
            },
            text: "Press Me",
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(timesOnPressedWasCalled, 0);

      await tester.tap(find.byType(Button));
      await tester.pumpAndSettle();

      expect(timesOnPressedWasCalled, 1);
    },
  );

  test(
    "WHEN button is not enabled THEN ensure colors returned are expected",
    () async {
      //ARRANGE
      final expectedBackgroundColor = Colors.grey.shade400;
      const expectedTextColor = Colors.white;
      final expectedBorderColor = Colors.grey.shade400;

      //ACT
      final backgroundColor =
          mixin.getBackgroundColor(false, ButtonType.primary);
      final textColor = mixin.getTextColor(false, ButtonType.primary);
      final borderColor = mixin.getBorderColor(false, ButtonType.primary);

      //ASSERT
      expect(expectedBackgroundColor, backgroundColor);
      expect(expectedTextColor, textColor);
      expect(expectedBorderColor, borderColor);
    },
  );

  test(
      'WHEN button is enabled and type is primary THEN ensure colors are correct',
      () async {
    //ARRANGE
    final expectedBackgroundColor = Colors.orange.shade400;
    const expectedTextColor = Colors.white;
    final expectedBorderColor = Colors.orange.shade400;

    //ACT
    final backgroundColor = mixin.getBackgroundColor(true, ButtonType.primary);
    final textColor = mixin.getTextColor(true, ButtonType.primary);
    final borderColor = mixin.getBorderColor(true, ButtonType.primary);

    //ASSERT
    expect(expectedBackgroundColor, backgroundColor);
    expect(expectedTextColor, textColor);
    expect(expectedBorderColor, borderColor);
  });

  test(
      'WHEN button is enabled and type is secondary THEN ensure colors are correct',
      () async {
    //ARRANGE
    const expectedBackgroundColor = Colors.white;
    final expectedTextColor = Colors.orange.shade400;
    final expectedBorderColor = Colors.orange.shade400;

    //ACT
    final backgroundColor =
        mixin.getBackgroundColor(true, ButtonType.secondary);
    final textColor = mixin.getTextColor(true, ButtonType.secondary);
    final borderColor = mixin.getBorderColor(true, ButtonType.secondary);

    //ASSERT
    expect(expectedBackgroundColor, backgroundColor);
    expect(expectedTextColor, textColor);
    expect(expectedBorderColor, borderColor);
  });
}
