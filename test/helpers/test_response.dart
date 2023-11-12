import 'package:dio/dio.dart';

class TestResponse extends Response {
  TestResponse(dynamic data)
      : super(requestOptions: RequestOptions(), data: data);
}
