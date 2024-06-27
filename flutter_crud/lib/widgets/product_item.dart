import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text('Stock: ${product.stock}, Date: ${product.date}'),
      trailing: product.inStock ? Icon(Icons.check, color: Colors.green) : Icon(Icons.close, color: Colors.red),
    );
  }
}
