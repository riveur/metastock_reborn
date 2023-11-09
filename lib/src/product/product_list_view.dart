import 'package:flutter/material.dart';
import 'package:metastock_reborn/src/models/product.dart';
import 'package:metastock_reborn/src/product/product_item.dart';
import 'package:metastock_reborn/src/utils/samples.dart';

class ProductListView extends StatelessWidget {
  ProductListView({super.key});

  final List<Product> products = Samples.getProducts();

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
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: const SearchBar(
              padding: MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16)),
              leading: Icon(Icons.search),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductItem(
                  product: products.elementAt(index),
                  onPressed: onClickProduct,
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(color: Colors.transparent),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onClickAdd,
        child: const Icon(Icons.add),
      ),
    );
  }
}
