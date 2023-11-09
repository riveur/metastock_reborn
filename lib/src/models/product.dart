class Product {
  const Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.picture,
      required this.unitPrice,
      required this.stock,
      required this.threshold,
      required this.archive});

  final int id;
  final String name;
  final String description;
  final String picture;
  final double unitPrice;
  final int stock;
  final int threshold;
  final bool archive;
}
