import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  void addItem(String plantName, double pricePerKg, String plantImage) {
    _items.add({
      'plantName': plantName,
      'pricePerKg': pricePerKg,
      'plantImage': plantImage,
    });
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
