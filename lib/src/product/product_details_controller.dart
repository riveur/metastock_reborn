import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:metastock_reborn/src/auth/auth_controller.dart';
import 'package:metastock_reborn/src/models/product.dart';
import 'package:metastock_reborn/src/product/product_service.dart';

enum ProductDetailsControllerStatus { initial, loading, error, fetched }

class ProductDetailsController extends GetxController {
  final ProductService _productService = ProductService();
  final AuthController _authController =
      Get.find(tag: (AuthController).toString());

  final _productId = "".obs;
  final product = Product.empty().obs;
  final status = ProductDetailsControllerStatus.initial.obs;

  @override
  void onInit() async {
    _productId.value = Get.parameters['id']!;
    await loadProduct();
    super.onInit();
  }

  Future<void> findById(String id) async {
    try {
      status.value = ProductDetailsControllerStatus.loading;
      product.value = await _productService.find(id);
      status.value = ProductDetailsControllerStatus.fetched;
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        await _authController.logout();
      }
      status.value = ProductDetailsControllerStatus.error;
    }
  }

  Future<void> loadProduct() async {
    if (_productId.isNotEmpty) {
      await findById(_productId.value);
    }
  }
}
