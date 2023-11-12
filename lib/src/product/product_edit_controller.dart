import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metastock_reborn/src/auth/auth_controller.dart';
import 'package:metastock_reborn/src/models/product.dart';
import 'package:metastock_reborn/src/product/product_service.dart';

enum ProductEditStatus { initial, loading, success, error }

class ProductEditController extends GetxController {
  final _product = Product.empty().obs;
  final status = ProductEditStatus.initial.obs;
  Rx<Product> get product => _product;

  final ProductService _productService = ProductService();
  final AuthController _authController =
      Get.find(tag: (AuthController).toString());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController pictureController = TextEditingController();
  final TextEditingController unitPriceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController thresholdController = TextEditingController();
  final RxBool archiveController = false.obs;

  @override
  void onInit() {
    var product = Get.arguments as Product?;
    if (product != null) {
      _product.value = product;
      nameController.text = _product.value.name;
      descriptionController.text = _product.value.description;
      pictureController.text = _product.value.picture;
      unitPriceController.text = _product.value.unitPrice.toString();
      stockController.text = _product.value.stock.toString();
      thresholdController.text = _product.value.threshold.toString();
      archiveController.value = _product.value.archive;
    }
    super.onInit();
  }

  Future<bool> saveProduct() async {
    status.value = ProductEditStatus.loading;
    var product = Product.fromJson({
      "id": _product.value.id,
      "name": nameController.text,
      "description": descriptionController.text,
      "picture": pictureController.text,
      "unitPrice": double.parse(unitPriceController.text),
      "stock": int.parse(stockController.text),
      "threshold": int.parse(thresholdController.text),
      'archive': archiveController.value
    });
    try {
      if (product.id == -1) {
        await _productService.create(product);
      } else {
        await _productService.edit(product);
      }
      status.value = ProductEditStatus.success;
      return true;
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        await _authController.logout();
      }
      status.value = ProductEditStatus.error;
      return false;
    }
  }
}
