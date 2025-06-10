class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String image;
  final bool inStock;
  final String category;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    this.inStock = true,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      'inStock': inStock,
      'category': category,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      image: json['image'],
      inStock: json['inStock'] ?? true,
      category: json['category'],
    );
  }
}