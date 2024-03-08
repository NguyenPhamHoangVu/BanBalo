class Product1 {
  final int id;
  final String name;
  final String sku;
  final String description;
  final int price;
  final int percentPromotion;
  final String material;
  final int stock;
  final String color;
  final String image1;
  final String image2;
  final String image3;
  final String image4;

  Product1(
      {required this.id,
      required this.sku,
      required this.name,
      required this.description,
      required this.price,
      required this.percentPromotion,
      required this.material,
      required this.stock,
      required this.color,
      required this.image1,
      required this.image2,
      required this.image3,
      required this.image4});

  factory Product1.fromJson(Map<String, dynamic> json) {
    return Product1(
      id: json['id'] as int,
      sku: json['sku'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as int,
      percentPromotion: json['percentPromotion'] as int,
      material: json['material'] as String,
      stock: json['stock'] as int,
      image1: json['image1'] as String,
      image2: json['image2'] as String,
      image3: json['image3'] as String,
      image4: json['image4'] as String,
      color: json['color'] as String,
    );
  }
}
