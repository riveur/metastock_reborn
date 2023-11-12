import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metastock_reborn/src/models/product.dart';
import 'package:metastock_reborn/src/product/product_details_controller.dart';
import 'package:metastock_reborn/src/product/product_item.dart';
import 'package:metastock_reborn/src/utils/constants.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Product details")),
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
    return Column(children: [
      Image.network(
        product.picture,
        height: 200,
      ),
      Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfos(product),
            const SizedBox(height: 20),
            _buildStock(product),
            const SizedBox(height: 20),
            _buildThreshold(product),
            const SizedBox(height: 20),
            _buildArchive(product),
            const SizedBox(height: 40),
          ],
        ),
      ),
    ]);
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
}
