import 'package:flutter/material.dart';
import 'package:provicer_api_project/core/theme/app_themes.dart';
import 'package:provicer_api_project/providers/product_provider.dart';
import 'package:provicer_api_project/views/product_form/product_form_screen.dart';

ListView ProductCard(ProductsProvider provider) {
  final tileColors = [
  AppColors.lavenderTile,
  AppColors.periwinkleTile,
];
  return ListView.builder(
    itemCount: provider.products.length,
    itemBuilder: (context, index) {
      final product = provider.products[index];
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
          elevation: 5,
          color: tileColors[index % 2],
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              child: Text("${index + 1}".toString(),style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)),
            title: Text(product.name ?? "Product Name", style: TextStyle(color: AppColors.tileTitle, fontWeight: FontWeight.bold),),
            subtitle: Text("${product.price ?? 0}".toString(), style: TextStyle(color: AppColors.tileSubtitle, fontWeight: FontWeight.bold),),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductFormScreen(product: product),
                        ),
                      );
                    },
                    icon: Icon(Icons.edit, color: AppColors.editIcon, size: 15,),
                  ),
                ),
                SizedBox(width: 5),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: IconButton(
                    onPressed: () {
                      provider.deleteProduct(product.id!);
                    },
                    icon: Icon(Icons.delete, color: AppColors.deleteIcon, size: 15,),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
