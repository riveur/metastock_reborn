import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metastock_reborn/src/product/product_edit_controller.dart';

class ProductEditView extends GetView<ProductEditController> {
  const ProductEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.product.value.id != -1
            ? "Produit n°${controller.product.value.id}"
            : "Nouveau produit"),
        actions: [
          Container(
              padding: const EdgeInsets.only(right: 8),
              child: Obx(
                () => FilledButton.tonal(
                  onPressed: () async {
                    if (await controller.saveProduct()) {
                      Get.back(result: 'success');
                    }
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Opacity(
                        opacity:
                            controller.status.value == ProductEditStatus.loading
                                ? 0
                                : 1,
                        child: Text(controller.product.value.id != -1
                            ? "Modifier"
                            : "Ajouter"),
                      ),
                      Opacity(
                          opacity: controller.status.value ==
                                  ProductEditStatus.loading
                              ? 1
                              : 0,
                          child: const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ))
                    ],
                  ),
                ),
              ))
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  autofocus: controller.product.value.id == -1,
                  controller: controller.nameController,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    labelText: "Nom",
                    border: OutlineInputBorder(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controller.descriptionController,
                  textAlign: TextAlign.start,
                  minLines: 3,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    labelText: "Description",
                    border: OutlineInputBorder(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  autofocus: controller.product.value.id == -1,
                  controller: controller.pictureController,
                  keyboardType: TextInputType.url,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    labelText: "Lien de l'image",
                    border: OutlineInputBorder(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controller.unitPriceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    labelText: "Prix unitaire",
                    border: OutlineInputBorder(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: Icon(Icons.euro, size: 20),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: controller.stockController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          labelText: "Stock",
                          border: OutlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Icon(Icons.cases_outlined, size: 20),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Flexible(
                      child: TextField(
                        controller: controller.thresholdController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          labelText: "Seuil d'alerte",
                          border: OutlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Icon(Icons.bolt, size: 20),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Archive"),
                    Obx(
                      () => Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: ChoiceChip(
                              label: const Text("Oui"),
                              selected: controller.archiveController.isTrue,
                              onSelected: (value) {
                                controller.archiveController.value = true;
                              },
                            ),
                          ),
                          Expanded(
                            child: ChoiceChip(
                              label: const Text("Non"),
                              selected: controller.archiveController.isFalse,
                              onSelected: (_) {
                                controller.archiveController.value = false;
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
