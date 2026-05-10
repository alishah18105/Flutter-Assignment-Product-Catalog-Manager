
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:provicer_api_project/model/products.model.dart';

class Api_Services{
final String url = "https://crudcrud.com/api/dc6830c7ec65445baf6a07e53c1ba70f/products";

//Get Function:-----------------------------------------------------------
Future<List<Products>> fetchApi() async{
 var response = await http.get(Uri.parse(url));
 if(response.statusCode == 200){
 List data = jsonDecode(response.body);
 return data.map((e) => Products.fromJson(e)).toList();
}
else{
  throw Exception("Failed To Load Products");
}
}

//POST Function:--------------------------------------------------------------------
Future<Products> addProducts(Products product) async{
  var response = await http.post(
    Uri.parse(url),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "id" : product.id,
      "name": product.name,
      "price": product.price
    })
  );
  if(response.statusCode == 200 || response.statusCode == 201){
 return Products.fromJson(jsonDecode(response.body));
}
else{
    throw Exception("Failed To Add Product");

}
}

//PUT Function:-----------------------------------------
Future<void> updateProducts(Products product) async{
  var response = await http.put(
    Uri.parse("$url/${product.id}"),
    headers: {"Content-Type" : "application/json"},
    body: jsonEncode({
      "id" : product.id,
      "name": product.name,
      "price": product.price
    }
    )
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