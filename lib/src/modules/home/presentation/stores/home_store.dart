import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_app/src/modules/home/data/usecase/get_home_info_usecase.dart';
import 'package:school_app/src/modules/home/presentation/stores/home_state.dart';

class HomeStore extends Cubit<HomeState> {
  final GetHomeInfoUsecase _usecase;

  HomeStore(this._usecase) : super(HomeInitial());

  void fetch() async {
    try {
      emit(HomeLoading());
      final result = await _usecase();
      emit(HomeSuccess(result));
    } catch (exception) {
      emit(HomeError(exception.toString()));
    }
  }
}
