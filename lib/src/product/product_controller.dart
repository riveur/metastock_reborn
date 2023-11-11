import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:metastock_reborn/src/auth/auth_controller.dart';
import 'package:metastock_reborn/src/models/product.dart';
import 'package:metastock_reborn/src/product/product_service.dart';

enum ProductControllerStatus { initial, loading, error, fetched }

class ProductController extends GetxController {
  final ProductService productService = ProductService();
  final AuthController _authController =
      Get.find(tag: (AuthController).toString());
  var products = <Product>[].obs;
  var filteredProducts = <Product>[].obs;
  final status = ProductControllerStatus.initial.obs;

  @override
  void onInit() {
    fetchAll();
    filteredProducts.value = products;
    super.onInit();
  }

  void fetchAll() async {
    try {
      status.value = ProductControllerStatus.loading;
      var result = await productService.findAll();
      products.value = result;
      status.value = ProductControllerStatus.fetched;
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        await _authController.logout();
      }
      status.value = ProductControllerStatus.error;
    }
  }

  void resetFilter() {
    filteredProducts.value = products;
  }
}
