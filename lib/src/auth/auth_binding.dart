import 'package:get/get.dart';
import 'package:metastock_reborn/src/auth/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(), tag: (AuthController).toString());
  }
}
