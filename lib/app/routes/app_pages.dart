import 'package:get/get.dart';

import '../modules/admin/add_data/bindings/add_data_binding.dart';
import '../modules/admin/add_data/views/add_data_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';

// import '../modules/home/bindings/home_binding.dart';
// import '../modules/home/views/home_view.dart';
// import '../modules/home/views/snap_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    // GetPage(
    //   name: _Paths.HOME,
    //   page: () => HomeView(),
    //   binding: HomeBinding(),
    // ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ADD_DATA,
      page: () => const AddDataView(),
      binding: AddDataBinding(),
    ),
  ];
}
