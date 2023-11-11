import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  int id;
  String name;
  String description;
  double unitPrice;
  int stock;
  int threshold;
  String picture;
  bool archive;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.unitPrice,
    required this.stock,
    required this.threshold,
    required this.picture,
    required this.archive,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        unitPrice: json["unitPrice"]?.toDouble(),
        stock: json["stock"],
        threshold: json["threshold"],
        picture: json["picture"],
        archive: json["archive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "unitPrice": unitPrice,
        "stock": stock,
        "threshold": threshold,
        "picture": picture,
        "archive": archive,
      };
}
