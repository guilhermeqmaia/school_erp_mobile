import 'package:dio/dio.dart';
import 'package:school_app/src/config.dart';

class DioHttpService {
  late final Dio _dio;

  DioHttpService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: Config.apiBaseUrl,
      ),
    );
  }

  Future<Response> get(String path) async {
    return await _dio.get(path);
  }

  Future<Response> post(String path, dynamic data) async {
    return await _dio.post(path, data: data);
  }

  Future<Response> put(String path, dynamic data) async {
    return await _dio.put(path, data: data);
  }

  Future<Response> delete(String path) async {
    return await _dio.delete(path);
  }
}
