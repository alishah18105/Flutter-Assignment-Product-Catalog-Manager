import 'package:flutter/material.dart';
import 'package:provicer_api_project/model/products.model.dart';
import 'package:provicer_api_project/services/products_services.dart';

class ProductsProvider extends ChangeNotifier{
Api_Services service = Api_Services();

bool _isLoading = false;
List<Products> _products = [];

bool get isLoading => _isLoading;
List<Products> get products => _products;

//Fetch Api Function:-----------------------------------
Future<void> fetchApi() async{
  _isLoading = true;
  notifyListeners();

  try{
    _products = await service.fetchApi();
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
    final newProduct =await service.addProducts(product);
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
    await service.updateProducts(product);
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
    await service.deleteProduct(id);
    _products.removeWhere((p)=> p.id == id);
    notifyListeners();
  }
  catch(e){
    print(e);
  }
}

}