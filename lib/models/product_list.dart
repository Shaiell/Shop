import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  List<Product> _items = dummyData;

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return [..._items.where((product) => product.isFavorite)];
  }

  int get itemsCount{
    return _items.length;
  }

  void saveProduct(Map<String,Object> data) {
    bool hasId = data['id'] != null;
    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: double.parse(data['price'] as String),
      imageUrl: data['imageUrl'] as String,
    );

    if(hasId){
      updateProduct(product);
    } else {
      addProduct(product);
    }

  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void updateProduct(Product product){
    int index = _items.indexWhere((p) => p.id == product.id);
    if(index >= 0){
      _items[index] = product;
      notifyListeners();
    }
  }

  void removeProduct(Product product){
    int index = _items.indexWhere((p) => p.id == product.id);
    if(index >= 0){
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }
}

// bool _showFavoriteOnly = false;
//
// List<Product> get items {
//   if (_showFavoriteOnly) {
//     return [..._items.where((product) => product.isFavorite)];
//   }
//   return [..._items];
// }
//
// void addProduct(Product product) {
//   _items.add(product);
//   notifyListeners();
// }
//
// void showFavoriteOnly() {
//   _showFavoriteOnly = true;
//   notifyListeners();
// }
//
// void showAll() {
//   _showFavoriteOnly = false;
//   notifyListeners();
// }
