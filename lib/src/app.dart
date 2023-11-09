import 'package:flutter/material.dart';
import 'package:metastock_reborn/src/login/login_view.dart';
import 'package:metastock_reborn/src/product/product_list_view.dart';
import 'package:metastock_reborn/src/utils/constants.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true, colorSchemeSeed: Constants.primaryColor),
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) {
              return ProductListView();
              // return const LoginView();
            });
      },
    );
  }
}
