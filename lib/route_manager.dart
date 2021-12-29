import 'package:car_system/view/create_client_view.dart';
import 'package:car_system/view/home_view.dart';
import 'package:car_system/view/login_view.dart';
import 'package:get/get.dart';

import 'all_binding.dart';

class RouterManager {
  static const String LOGIN = '/login';
  static const String REGISTER_CLIENT = '/register_client';
  static const String HOME = '/home';

  static List<GetPage> getRoutes() => [
    GetPage(name: LOGIN, page: () => LoginView(), binding: AllBinding()),
    GetPage(name: REGISTER_CLIENT, page: () => RegisterClientView(), binding: AllBinding()),
    GetPage(name: HOME, page: () => HomeView(), binding: AllBinding()),
  ];
}