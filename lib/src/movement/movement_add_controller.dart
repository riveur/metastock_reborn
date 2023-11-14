import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:metastock_reborn/src/auth/auth_controller.dart';
import 'package:metastock_reborn/src/models/movement.dart';
import 'package:metastock_reborn/src/movement/movement_service.dart';
import 'package:metastock_reborn/src/product/product_details_controller.dart';

enum MovementAddStatus { initial, loading, success, error }

class MovementAddController extends GetxController {
  final MovementService _movementService = MovementService();
  final AuthController _authController =
      Get.find(tag: (AuthController).toString());
  final ProductDetailsController productDetailsController =
      Get.find<ProductDetailsController>();

  final status = MovementAddStatus.initial.obs;
  final TextEditingController commentController =
      TextEditingController(text: "");
  final quantityController = "".obs;
  final movementTypeController = MovementType.entry.obs;

  Future<bool> saveMovement() async {
    status.value = MovementAddStatus.loading;
    Map<String, dynamic> data = {
      "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
      "quantity": quantityController.value,
      "comment": commentController.text,
      "type":
          movementTypeController.value == MovementType.entry ? "ENTRY" : "EXIT",
      "product": {"id": productDetailsController.product.value.id}
    };
    try {
      await _movementService.create(data);
      status.value = MovementAddStatus.success;
      return true;
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        await _authController.logout();
      }
      status.value = MovementAddStatus.error;
      return false;
    }
  }
}
