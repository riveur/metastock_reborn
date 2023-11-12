import 'package:get/get.dart';
import 'package:metastock_reborn/src/auth/auth_binding.dart';
import 'package:metastock_reborn/src/movement/movement_list_controller.dart';
import 'package:metastock_reborn/src/product/product_details_controller.dart';

class ProductDetailsBinding extends Bindings {
  @override
  void dependencies() {
    AuthBinding().dependencies();
    Get.lazyPut<ProductDetailsController>(() => ProductDetailsController());
    Get.lazyPut<MovementListController>(() => MovementListController(),
        tag: (MovementListController).toString());
  }
}
