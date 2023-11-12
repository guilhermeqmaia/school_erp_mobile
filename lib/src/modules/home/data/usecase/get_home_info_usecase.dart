import 'package:school_app/src/modules/home/data/model/home_model.dart';
import 'package:school_app/src/shared/services/dio_http_service.dart';

class GetHomeInfoUsecase {
  final DioHttpService _dioClient;

  GetHomeInfoUsecase(this._dioClient);

  Future<HomeModel> call() async {
    final result = await _dioClient.get('');

    return HomeModel.fromJson(result.data);
  }
}
