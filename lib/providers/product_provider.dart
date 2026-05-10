import 'package:flutter/material.dart';
import 'package:provicer_api_project/models/product..dart';
import 'package:provicer_api_project/services/product_service.dart';

class ProductsProvider extends ChangeNotifier{
final ProductService _service = ProductService();

bool _isLoading = false;
List<Products> _products = [];
String? _errorMessage;

bool get isLoading => _isLoading;
List<Products> get products => _products;
String? get errorMessage => _errorMessage;
bool get hasError => _errorMessage != null;
bool get isEmpty => !_isLoading && _products.isEmpty;

//Fetch Api Function:-----------------------------------
Future<void> fetchApi() async{
  _isLoading = true;
  notifyListeners();

  try{
    _products = await _service.fetchProducts();
  }
  catch(e){
    print(e);
  }
  _isLoading = false;
  notifyListeners();
}

//Post Product Function:---------------------------------
Future<void> addProducts(Products product) async{
  try{
    final newProduct =await _service.createProduct(product);
    _products.add(newProduct);
      notifyListeners();

  }
  catch(e){
    print(e);
  }

}
//Update Product Function:---------------------------------
Future<void> updateProducts(Products product) async{
  try{
    await _service.updateProduct(product);
    final index = _products.indexWhere((p)=> p.id == product.id);
    if(index != -1){
      _products[index] = product;
      notifyListeners();
    }
  }
  catch(e){
    print(e);
  }
}

//DELETE PRODUCT Function:---------------------------------
Future<void> deleteProducts(String id) async{
  try{
    await _service.deleteProduct(id);
    _products.removeWhere((p)=> p.id == id);
    notifyListeners();
  }
  catch(e){
    print(e);
  }
}

}