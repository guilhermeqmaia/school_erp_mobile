import 'package:flutter_modular/flutter_modular.dart';
import 'package:school_app/src/modules/home/data/usecase/get_home_info_usecase.dart';
import 'package:school_app/src/modules/home/presentation/pages/home_page.dart';
import 'package:school_app/src/modules/home/presentation/stores/home_store.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> binds = [
    //Usecases
    Bind.factory<GetHomeInfoUsecase>((i) => GetHomeInfoUsecase(i())),

    //Stores
    Bind.lazySingleton<HomeStore>((i) => HomeStore(i())),
  ];

  @override
  List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, __) => const HomePage(),
    )
  ];
}
