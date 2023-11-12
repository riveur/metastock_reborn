import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metastock_reborn/src/models/product.dart';
import 'package:metastock_reborn/src/movement/movement_item.dart';
import 'package:metastock_reborn/src/movement/movement_list_controller.dart';
import 'package:metastock_reborn/src/product/product_controller.dart';
import 'package:metastock_reborn/src/product/product_details_controller.dart';
import 'package:metastock_reborn/src/product/product_item.dart';
import 'package:metastock_reborn/src/utils/constants.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  ProductDetailsView({super.key});

  final MovementListController _movementListController =
      Get.find(tag: (MovementListController).toString());
  final ProductController _productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Détail du produit"),
          actions: [
            IconButton(
                onPressed: () async {
                  var result = await Get.toNamed('/product/edit',
                      arguments: controller.product.value);

                  if (result == 'success') {
                    controller.loadProduct();
                    _productController.fetchAll();
                  }
                },
                icon: const Icon(Icons.edit)),
          ],
        ),
        body: Obx(() {
          switch (controller.status.value) {
            case ProductDetailsControllerStatus.fetched:
              return _finalView();
            case ProductDetailsControllerStatus.error:
              return const Center(
                child: Text('Erreur lors de la récupération du produit'),
              );
            case ProductDetailsControllerStatus.loading:
            case ProductDetailsControllerStatus.initial:
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        }));
  }

  Widget _finalView() {
    var product = controller.product.value;
    return Column(
      children: [
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    product.picture,
                    height: 200,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildInfos(product),
                        const SizedBox(height: 20),
                        _buildStock(product),
                        const SizedBox(height: 20),
                        _buildThreshold(product),
                        const SizedBox(height: 20),
                        _buildArchive(product),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildMovements()
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfos(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                product.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              "${product.unitPrice}€",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ),
        Text(product.description, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildStock(Product product) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 8),
          child: Icon(
            Icons.cases_outlined,
            size: 32,
          ),
        ),
        const Text(
          "En stock: ",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          "${product.stock}",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ProductItem.colorByStockAndThreshold(
                  product.stock, product.threshold)),
        ),
      ],
    );
  }

  Widget _buildThreshold(Product product) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 8),
          child: Icon(
            Icons.bolt,
            size: 32,
          ),
        ),
        Text(
          "Seuil d'alerte: ${product.threshold}",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: product.archive ? Constants.warningColor : null),
        ),
      ],
    );
  }

  Widget _buildArchive(Product product) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 8),
          child: Icon(
            Icons.archive_outlined,
            size: 32,
          ),
        ),
        Text(
          product.archive
              ? "Ce produit est archivé"
              : "Ce produit n'est pas archivé",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: product.archive ? Constants.warningColor : null),
        ),
      ],
    );
  }

  Widget _buildMovements() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Mouvements",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              OutlinedButton(onPressed: () {}, child: const Text("Nouveau"))
            ],
          ),
        ),
        _movementListController.movements.isEmpty
            ? Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: const Text("Pas de mouvements pour ce produit"),
              )
            : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var movement =
                      _movementListController.movements.elementAt(index);
                  return MovementItem(movement: movement);
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: _movementListController.movements.length,
              )
      ],
    );
  }
}
