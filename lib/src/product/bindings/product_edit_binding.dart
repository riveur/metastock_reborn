import 'package:get/get.dart';
import 'package:metastock_reborn/src/auth/auth_binding.dart';
import 'package:metastock_reborn/src/product/product_edit_controller.dart';

class ProductEditBinding extends Bindings {
  @override
  void dependencies() {
    AuthBinding().dependencies();
    Get.lazyPut<ProductEditController>(() => ProductEditController());
  }
}
