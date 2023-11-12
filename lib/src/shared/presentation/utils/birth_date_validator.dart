class BirthDateValidator {
  static String? validate(String value) {
    final dateTime = value.split('/');

    if (dateTime.length != 3) return "Data inválida";

    final day = int.tryParse(dateTime[0]);
    final month = int.tryParse(dateTime[1]);
    final year = int.tryParse(dateTime[2]);

    if (day == null || month == null || year == null) {
      return "Data inválida";
    }

    final date = DateTime(year, month, day);

    if (date.isAfter(DateTime.now())) {
      return "Data não pode ser no futuro";
    }

    if (date.isBefore(DateTime(1850))) {
      return "Não é possível cadastrar essa data";
    }

    return null;
  }
}
