import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:metastock_reborn/src/auth/auth_controller.dart';
import 'package:metastock_reborn/src/models/product.dart';
import 'package:metastock_reborn/src/utils/api.dart';

class ProductService {
  final AuthController authController =
      Get.find(tag: (AuthController).toString());
  final dio = Dio();

  Future<List<Product>> findAll() async {
    String? token = await authController.getToken();

    var response = await dio.get<List<dynamic>>(Api.endpoint('/products'),
        options: Options(headers: {"Authorization": "Bearer $token"}));

    return response.data?.map((value) => Product.fromJson(value)).toList() ??
        [];
  }

  Future<Product> find(String id) async {
    String? token = await authController.getToken();

    var response = await dio.get<dynamic>(Api.endpoint('/products/$id'),
        options: Options(headers: {"Authorization": "Bearer $token"}));

    return Product.fromJson(response.data);
  }

  Future<Product> create(Product product) async {
    String? token = await authController.getToken();

    Map<String, dynamic> values = product.toJson();
    values.remove("id");

    var response = await dio.post<dynamic>(
      Api.endpoint('/products'),
      options: Options(headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      }),
      data: values,
    );

    return Product.fromJson(response.data);
  }

  Future<Product> edit(Product product) async {
    String? token = await authController.getToken();

    var response = await dio.put<dynamic>(
      Api.endpoint('/products/${product.id}'),
      options: Options(headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      }),
      data: product.toJson(),
    );

    return Product.fromJson(response.data);
  }
}
