import 'package:flutter/foundation.dart';

class Config {
  static get apiBaseUrl {
    if (_apiBaseUrl.isEmpty) {
      debugPrint(
          "Não é possível executar a aplicação sem a variável de ambiente definida/n ${StackTrace.current}");
      throw "";
    }
    return _apiBaseUrl;
  }

  static const String _apiBaseUrl = "";
}
