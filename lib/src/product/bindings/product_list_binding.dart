import 'package:get/get.dart';
import 'package:metastock_reborn/src/auth/auth_binding.dart';
import 'package:metastock_reborn/src/product/product_controller.dart';

class ProductListBinding extends Bindings {
  @override
  void dependencies() {
    AuthBinding().dependencies();
    Get.lazyPut<ProductController>(() => ProductController());
  }
}
