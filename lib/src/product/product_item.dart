import 'package:flutter/material.dart';
import 'package:metastock_reborn/src/models/product.dart';
import 'package:metastock_reborn/src/utils/constants.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, this.onPressed, required this.product});

  final Product product;
  final void Function(Product product)? onPressed;

  static Color colorByStockAndThreshold(int stock, int threshold) {
    if (stock == 0) return Constants.dangerColor;
    if (stock < threshold) return Constants.warningColor;
    return Constants.primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(width: 50, child: Image.network(product.picture)),
      enabled: true,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Flexible(
          child: Text(
            product.name,
            overflow: TextOverflow.ellipsis,
          ),
        ),
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
              color:
                  colorByStockAndThreshold(product.stock, product.threshold)),
        )
      ]),
      onTap: () {
        onPressed!(product);
      },
    );
  }
}
