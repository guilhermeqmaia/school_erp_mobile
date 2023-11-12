import 'package:flutter_test/flutter_test.dart';
import 'package:school_app/src/shared/presentation/utils/format_date.dart';

void main() {
  test('GIVEN a valid date WHEN call format THEN ensure return is expected',
      () async {
    //Arrange
    const mockDate = "09/11/2021";
    final expectedResult = DateTime(2021, 11, 9);

    //Act
    final result = FormatDate.format(mockDate);

    //Assert
    expect(result, expectedResult);
  });

  test('GIVEN an invalid date WHEN call format THEN ensure throws an error',
      () async {
    //Arrange
    const mockDate = "14/NOVEMEBER/2021";
    const expectedResult = throwsException;

    //Act
    expect(() => FormatDate.format(mockDate), expectedResult);
    //Assert
  });
}
