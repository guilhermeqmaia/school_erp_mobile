import 'package:flutter_test/flutter_test.dart';
import 'package:school_app/src/shared/presentation/utils/birth_date_validator.dart';

void main() {
  test(
      'GIVEN an invalid date WHEN call validate THEN ensure return message is expected',
      () async {
    //Arrange
    const mockDate = "21/05/";
    const expectedResult = "Data inválida";

    //Act
    final result = BirthDateValidator.validate(mockDate);

    //Assert
    expect(result, expectedResult);
  });

  test(
      'GIVEN a date with String characters WHEN call validate THEN ensure return message is expected',
      () async {
    //Arrange
    const mockDate = "12/march/2023";
    const expectedResult = "Data inválida";

    //Act
    final result = BirthDateValidator.validate(mockDate);

    //Assert
    expect(result, expectedResult);
  });

  test(
      'GIVEN a Future date WHEN call validate THEN ensure return message is expected',
      () async {
    //Arrange
    final now = DateTime.now();
    final future = now.add(const Duration(days: 1));
    final mockDate = "${future.day}/${future.month}/${future.year}";
    const expectedResult = "Data não pode ser no futuro";

    //Act
    final result = BirthDateValidator.validate(mockDate);

    //Assert
    expect(result, expectedResult);
  });

  test(
      'GIVEN an ancient date WHEN call validate THEN ensure return is expected',
      () async {
    //Arrange
    const mockDate = "25/12/0000";
    const expectedResult = "Não é possível cadastrar essa data";

    //Act
    final result = BirthDateValidator.validate(mockDate);

    //Assert
    expect(result, expectedResult);
  });

  test("GIVEN a valid date WHEN call validate THEN ensure return is expected",
      () async {
    //Arrange
    final beforeYesterday = DateTime.now().subtract(const Duration(days: 2));
    final mockDate =
        "${beforeYesterday.day}/${beforeYesterday.month}/${beforeYesterday.year}";
    const expectedResult = null;

    //Act
    final result = BirthDateValidator.validate(mockDate);

    //Assert
    expect(result, expectedResult);
  });
}
