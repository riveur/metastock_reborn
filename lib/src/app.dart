import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metastock_reborn/src/auth/auth_controller.dart';
import 'package:metastock_reborn/src/login/login_view.dart';
import 'package:metastock_reborn/src/product/product_list_view.dart';
import 'package:metastock_reborn/src/utils/constants.dart';

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _pages = <GetPage>[
    GetPage(name: '/login', page: () => LoginView()),
    GetPage(name: '/products', page: () => ProductListView()),
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    return GetMaterialApp(
      theme: ThemeData(
          useMaterial3: true, colorSchemeSeed: Constants.primaryColor),
      initialRoute: '/products',
      getPages: _pages,
    );
  }
}
