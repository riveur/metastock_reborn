import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:metastock_reborn/src/auth/auth_controller.dart';
import 'package:metastock_reborn/src/models/movement.dart';
import 'package:metastock_reborn/src/utils/api.dart';

class MovementService {
  final AuthController _authController =
      Get.find(tag: (AuthController).toString());
  final _dio = Dio();

  Future<List<Movement>> findAllByProduct(String productId) async {
    String? token = await _authController.getToken();

    var response = await _dio.get<List<dynamic>>(
        Api.endpoint('/products/$productId/movements'),
        options: Options(headers: {"Authorization": "Bearer $token"}));

    return response.data?.map((value) => Movement.fromJson(value)).toList() ??
        [];
  }
}
