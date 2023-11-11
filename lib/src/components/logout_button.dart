import 'package:flutter/material.dart';
import 'package:metastock_reborn/src/auth/auth_controller.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    void onPressed() async {
      await AuthController.find.logout();
    }

    return IconButton(onPressed: onPressed, icon: const Icon(Icons.logout));
  }
}
