import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metastock_reborn/src/components/movement_choose_type_button.dart';
import 'package:metastock_reborn/src/models/movement.dart';
import 'package:metastock_reborn/src/movement/movement_add_controller.dart';
import 'package:metastock_reborn/src/utils/constants.dart';

class MovementAddView extends GetView<MovementAddController> {
  const MovementAddView({super.key});

  void _handleSubmit() {
    controller.saveMovement().then((status) {
      if (status) {
        Get.back(result: 'success');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Effectuer un mouvement")),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildForm(),
                const Divider(height: 40),
                _buildEffects(),
                const Divider(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => FilledButton(
                        onPressed: _handleSubmit,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Opacity(
                              opacity: controller.status.value ==
                                      MovementAddStatus.loading
                                  ? 0
                                  : 1,
                              child: const Text("Valider"),
                            ),
                            Opacity(
                                opacity: controller.status.value ==
                                        MovementAddStatus.loading
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
                        )))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        TextField(
          autofocus: true,
          onChanged: (value) {
            controller.quantityController.value = value;
          },
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            labelText: "Quantité",
            border: OutlineInputBorder(),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: Icon(Icons.numbers, size: 20),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: controller.commentController,
          minLines: 3,
          maxLines: 3,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            labelText: "Commentaire",
            border: OutlineInputBorder(),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),
        const SizedBox(height: 20),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const Text("ENTRÉE",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  MovementChooseTypeButton(
                    icon: const Icon(Icons.add, size: 70),
                    selected: controller.movementTypeController.value ==
                        MovementType.entry,
                    onPressed: () {
                      controller.movementTypeController.value =
                          MovementType.entry;
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  const Text("SORTIE",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  MovementChooseTypeButton(
                    icon: const Icon(Icons.remove, size: 70),
                    selected: controller.movementTypeController.value ==
                        MovementType.exit,
                    onPressed: () {
                      controller.movementTypeController.value =
                          MovementType.exit;
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEffects() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Effets sur le produit",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(controller.productDetailsController.product.value.name),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.cases_outlined, size: 30),
            const SizedBox(width: 10),
            const Text(
              "Stock:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10),
            Obx(() => Text(
                  _getStockMovementType(controller.movementTypeController.value)
                      .toString(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )),
          ],
        ),
        Obx(
          () => Visibility(
            visible:
                _getStockMovementType(controller.movementTypeController.value) <
                    controller.productDetailsController.product.value.threshold,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.bolt, size: 30),
                    const SizedBox(width: 10),
                    Text(
                      "Seuil de ${controller.productDetailsController.product.value.threshold} atteint",
                      style: TextStyle(
                          fontSize: 20,
                          color: Constants.warningColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Obx(
          () => Visibility(
            visible: _getStockMovementType(
                    controller.movementTypeController.value) <=
                0,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.warning_amber_rounded, size: 30),
                    const SizedBox(width: 10),
                    Text(
                      "Plus de stock",
                      style: TextStyle(
                          fontSize: 20,
                          color: Constants.dangerColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  int _getStockMovementType(MovementType type) {
    int parsedQuantity = 0;
    try {
      parsedQuantity = int.parse(controller.quantityController.value);
      // ignore: empty_catches
    } catch (e) {}

    switch (type) {
      case MovementType.entry:
        return controller.productDetailsController.product.value.stock +
            parsedQuantity;
      case MovementType.exit:
        return controller.productDetailsController.product.value.stock -
            parsedQuantity;
    }
  }
}
