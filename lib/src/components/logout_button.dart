import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metastock_reborn/src/auth/auth_controller.dart';

class LogoutButton extends StatelessWidget {
  LogoutButton({super.key});

  final AuthController _authController =
      Get.find(tag: (AuthController).toString());

  @override
  Widget build(BuildContext context) {
    void onPressed() async {
      await _authController.logout();
    }

    return IconButton(onPressed: onPressed, icon: const Icon(Icons.logout));
  }
}
