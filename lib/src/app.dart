import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metastock_reborn/src/auth/auth_binding.dart';
import 'package:metastock_reborn/src/login/login_view.dart';
import 'package:metastock_reborn/src/product/bindings/product_details_binding.dart';
import 'package:metastock_reborn/src/product/bindings/product_edit_binding.dart';
import 'package:metastock_reborn/src/product/bindings/product_list_binding.dart';
import 'package:metastock_reborn/src/product/product_details_view.dart';
import 'package:metastock_reborn/src/product/product_edit_view.dart';
import 'package:metastock_reborn/src/product/product_list_view.dart';
import 'package:metastock_reborn/src/utils/constants.dart';

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _pages = <GetPage>[
    GetPage(
      name: '/login',
      page: () => LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/products',
      page: () => ProductListView(),
      binding: ProductListBinding(),
    ),
    GetPage(
      name: '/products/:id',
      page: () => ProductDetailsView(),
      binding: ProductDetailsBinding(),
    ),
    GetPage(
      name: '/product/edit',
      page: () => const ProductEditView(),
      binding: ProductEditBinding(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          useMaterial3: true, colorSchemeSeed: Constants.primaryColor),
      initialRoute: '/products',
      getPages: _pages,
    );
  }
}
