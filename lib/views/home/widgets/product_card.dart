import 'package:flutter/material.dart';
import 'package:provicer_api_project/models/product.dart';
import 'package:provicer_api_project/providers/product_provider.dart';

ListView ProductCard(ProductsProvider provider) {
    return ListView.builder(
            itemCount: provider.products.length,
            itemBuilder: (context, index) {
              final product = provider.products[index];
              return ListTile(
                leading: Text("${index + 1}".toString()),
                title: Text(product.name ?? "Product Name"),
                subtitle: Text("${product.price ?? 0}".toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        final item = Products(
                          id: product.id,
                          name: "Wireless Mouse",
                          price: 1500,
                        );
                        provider.updateProduct(item);
                      },
                      icon: Icon(Icons.edit),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        provider.deleteProduct(product.id!);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          );
  }
  
  
