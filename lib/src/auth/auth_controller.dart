import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:metastock_reborn/src/auth/auth_service.dart';

class AuthController extends GetxController {
  final isLoggedIn = false.obs;
  final isLoading = false.obs;
  final AuthService _authService = AuthService();
  final storage = const FlutterSecureStorage();

  @override
  void onInit() async {
    await checkAuth();
    super.onInit();
  }

  static AuthController get find => Get.find<AuthController>();

  Future<void> checkAuth() async {
    if (await getToken() != null) {
      isLoggedIn.value = true;
    } else {
      Get.offNamed("/login");
    }
  }

  Future<String?> getToken() async {
    return await storage.read(key: AuthService.tokenKey);
  }

  Future<bool> login(String username, String password) async {
    isLoading(true);
    isLoggedIn.value = await _authService.login(username, password);
    isLoading(false);
    return isLoggedIn.value;
  }

  Future<void> logout() async {
    isLoading(true);
    await _authService.logout();
    await checkAuth();
    isLoading(false);
  }
}
