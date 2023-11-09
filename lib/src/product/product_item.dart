import 'package:flutter/material.dart';
import 'package:metastock_reborn/src/models/product.dart';
import 'package:metastock_reborn/src/utils/constants.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, this.onPressed, required this.product});

  final Product product;
  final void Function(Product product)? onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.bakery_dining_outlined,
      ),
      enabled: true,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(product.name),
        Text(
          "${product.unitPrice}€",
          style: const TextStyle(fontWeight: FontWeight.bold),
        )
      ]),
      subtitle: Text(product.description),
      trailing: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.cases_outlined),
        Text(
          "${product.stock}",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: product.stock > product.threshold
                  ? Constants.primaryColor
                  : Constants.dangerColor),
        )
      ]),
      onTap: () {
        onPressed!(product);
      },
    );
  }
}
