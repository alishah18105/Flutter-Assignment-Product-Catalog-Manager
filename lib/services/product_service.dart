
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:provicer_api_project/core/constants/api_constants.dart';
import 'package:provicer_api_project/models/product.dart';

class ProductService{
final String url = ApiConstants.productsEndpoint;

//Get Function:-----------------------------------------------------------
Future<List<Products>> fetchProducts() async {
  final response = await http.get(Uri.parse(url));
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    final List data = jsonDecode(response.body);
    return data.map((e) => Products.fromJson(e)).toList();
  } else {
    throw Exception("Failed to load products");
  }
}

//POST Function:--------------------------------------------------------------------
Future<Products> createProduct(Products product) async{
  var response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(product.toJson())
  );
  if(response.statusCode == 200 || response.statusCode == 201){
    print(response.statusCode);
    print(response.body);
 return Products.fromJson(jsonDecode(response.body));
}
else{
    throw Exception("Failed To Add Product");

}
}

//PUT Function:-----------------------------------------
Future<void> updateProduct(Products product) async{
  var response = await http.put(
    Uri.parse("$url/${product.id}"),
    headers: {"Content-Type" : "application/json"},
    body: jsonEncode(product.toJson())
  );
if(response.statusCode != 200){
  throw Exception("Failed to update product");
}
}


//DELETE Function:---------------------------------------
 Future<void> deleteProduct(String id)async{
  var response = await http.delete(
    Uri.parse(
      "$url/$id"
    ),
    headers: {"Content-Type": "application/json"},
  );

  if(response.statusCode != 200){
  throw Exception("Failed to delete product");
}
  
 }
}