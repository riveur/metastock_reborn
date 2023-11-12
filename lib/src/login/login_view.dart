import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metastock_reborn/src/auth/auth_controller.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final AuthController _authController =
      Get.find(tag: (AuthController).toString());

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void handleSubmit() {
      _authController
          .login(usernameController.text, passwordController.text)
          .then((status) {
        if (status) {
          Get.offNamed('/products');
        } else {
          Get.showSnackbar(const GetSnackBar(
            message: 'Identifiants incorrect',
            duration: Duration(seconds: 3),
          ));
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
      ),
      body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "MetaStock",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
              const Divider(),
              const SizedBox(height: 10),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                    labelText: "Nom d'utilisateur",
                    border: OutlineInputBorder(),
                    floatingLabelBehavior: FloatingLabelBehavior.always),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: "Mot de passe",
                    border: OutlineInputBorder(),
                    floatingLabelBehavior: FloatingLabelBehavior.always),
                onSubmitted: (value) {
                  handleSubmit();
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(() => FilledButton(
                        onPressed: _authController.isLoading.value
                            ? null
                            : handleSubmit,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Opacity(
                              opacity: _authController.isLoading.value ? 1 : 0,
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).disabledColor,
                                ),
                              ),
                            ),
                            Opacity(
                                opacity:
                                    _authController.isLoading.value ? 0 : 1,
                                child: const Text('Se connecter'))
                          ],
                        ),
                      ))
                ],
              )
            ],
          )),
    );
  }
}
