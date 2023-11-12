import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:metastock_reborn/src/auth/auth_controller.dart';
import 'package:metastock_reborn/src/models/movement.dart';
import 'package:metastock_reborn/src/movement/movement_service.dart';

enum MovementListControllerStatus { initial, loading, error, fetched }

class MovementListController extends GetxController {
  final MovementService _movementService = MovementService();
  final AuthController _authController =
      Get.find(tag: (AuthController).toString());
  var movements = <Movement>[].obs;
  var filteredMovements = <Movement>[].obs;
  final status = MovementListControllerStatus.initial.obs;

  @override
  void onInit() {
    var productId = Get.parameters['id'];
    if (productId != null) {
      fetchAllByProduct(productId);
    }
    filteredMovements.value = movements;
    super.onInit();
  }

  void fetchAllByProduct(String productId) async {
    try {
      status.value = MovementListControllerStatus.loading;
      var result = await _movementService.findAllByProduct(productId);
      movements.value = result;
      status.value = MovementListControllerStatus.fetched;
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        await _authController.logout();
      }
      status.value = MovementListControllerStatus.error;
    }
  }

  void resetFilter() {
    filteredMovements.value = movements;
  }
}
