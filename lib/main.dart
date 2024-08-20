import 'package:flutter/material.dart';
import 'package:flutter_ongkir_indonesia/routes/app_routes.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoute.main,
      getPages: AppRoute.routes,
    );
  }
}
