import 'package:metastock_reborn/src/models/product.dart';

class Samples {
  static List<Product> getProducts() {
    return const [
      Product(
          id: 1,
          name: "Carte graphique",
          description: "Une bete serieux",
          picture: "No image",
          unitPrice: 155.2,
          stock: 50,
          threshold: 10,
          archive: false),
      Product(
          id: 1,
          name: "Ecran 144hz",
          description: "C'est fluide",
          picture: "No image",
          unitPrice: 333.2,
          stock: 78,
          threshold: 5,
          archive: false),
      Product(
          id: 1,
          name: "Clavier de bz",
          description: "Mecanique le bail",
          picture: "No image",
          unitPrice: 1333.2,
          stock: 5,
          threshold: 10,
          archive: false),
    ];
  }
}
