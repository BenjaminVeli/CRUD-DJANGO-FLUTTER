class Product {
  final int id;
  final String name;
  final int stock;
  final String date;
  final bool inStock;

  Product({
    required this.id,
    required this.name,
    required this.stock,
    required this.date,
    required this.inStock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      stock: json['stock'],
      date: json['date'],
      inStock: json['in_stock'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'stock': stock,
      'date': date,
      'in_stock': inStock,
    };
  }
}
