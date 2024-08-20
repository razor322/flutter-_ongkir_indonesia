import 'package:flutter_ongkir_indonesia/screens/home/home_screen.dart';
import 'package:get/get.dart';

class AppRoute {
  static const main = '/';

  static final routes = [
    GetPage(name: AppRoute.main, page: () => HomeScreen()),
  ];
}
