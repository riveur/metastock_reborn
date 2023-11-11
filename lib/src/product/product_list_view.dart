import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metastock_reborn/src/components/floating_button.dart';
import 'package:metastock_reborn/src/components/logout_button.dart';
import 'package:metastock_reborn/src/models/product.dart';
import 'package:metastock_reborn/src/product/product_controller.dart';
import 'package:metastock_reborn/src/product/product_item.dart';

class ProductListView extends GetView<ProductController> {
  ProductListView({super.key});

  final ScrollController scrollController = ScrollController();

  void searchProduct(String query) {
    if (query.isEmpty) {
      controller.resetFilter();
      return;
    }

    final target = controller.products.where((product) {
      var name = product.name.toLowerCase();
      var description = product.description.toLowerCase();
      return name.contains(query.toLowerCase()) ||
          description.contains(query.toLowerCase());
    }).toList();

    controller.filteredProducts.value = target;
  }

  @override
  Widget build(BuildContext context) {
    void onClickProduct(Product product) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Produit clické: ${product.name}"),
      ));
    }

    void onClickAdd() {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Ajout d'un produit"),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des produits"),
        actions: [LogoutButton()],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            child: SearchBar(
              onChanged: searchProduct,
              padding: const MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16)),
              leading: const Icon(Icons.search),
            ),
          ),
          Expanded(
            child: Obx(() {
              switch (controller.status.value) {
                case ProductControllerStatus.error:
                  return const Center(
                    child: Text('Erreur lors de la récupération des produits'),
                  );
                case ProductControllerStatus.fetched:
                  return RefreshIndicator(
                    onRefresh: () async {
                      controller.fetchAll();
                    },
                    child: ListView.separated(
                      itemCount: controller.filteredProducts.length,
                      controller: scrollController,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductItem(
                          product: controller.filteredProducts.elementAt(index),
                          onPressed: onClickProduct,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(color: Colors.transparent),
                    ),
                  );
                case ProductControllerStatus.initial:
                case ProductControllerStatus.loading:
                default:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
              }
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingButton(
        onPressed: onClickAdd,
        controller: scrollController,
      ),
    );
  }
}
