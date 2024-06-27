import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/product_model.dart';
import '../services/api_service.dart';

class UpdateProductScreen extends StatefulWidget {
  final Product product;

  UpdateProductScreen({required this.product});

  @override
  _UpdateProductScreenState createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _stockController;
  late TextEditingController _dateController;
  late bool _inStock;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _stockController = TextEditingController(text: widget.product.stock.toString());
    _dateController = TextEditingController(text: widget.product.date);
    _inStock = widget.product.inStock;
    _selectedDate = DateTime.parse(widget.product.date);
  }

  Future<void> _updateProduct() async {
    if (_formKey.currentState!.validate()) {
      Product updatedProduct = Product(
        id: widget.product.id,
        name: _nameController.text,
        stock: int.parse(_stockController.text),
        date: _dateController.text,
        inStock: _inStock,
      );

      await ApiService().updateProduct(updatedProduct);
      Navigator.pop(context, true); // Return true indicating updated
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _stockController,
                decoration: InputDecoration(
                  labelText: 'Stock Quantity',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the stock quantity';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Expiration Date',
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () {
                  _selectDate(context);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an expiration date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              CheckboxListTile(
                title: Text('In Stock'),
                value: _inStock,
                onChanged: (bool? value) {
                  setState(() {
                    _inStock = value ?? false;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateProduct,
                child: Text('Update Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
