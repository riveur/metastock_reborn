import 'package:get/get.dart';
import 'package:metastock_reborn/src/movement/movement_add_controller.dart';
import 'package:metastock_reborn/src/product/bindings/product_details_binding.dart';

class MovementAddBinding extends Bindings {
  @override
  void dependencies() {
    ProductDetailsBinding().dependencies();
    Get.lazyPut<MovementAddController>(() => MovementAddController());
  }
}
