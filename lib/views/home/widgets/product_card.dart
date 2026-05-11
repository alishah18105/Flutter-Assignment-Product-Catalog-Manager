import 'package:flutter/material.dart';
import 'package:provicer_api_project/core/theme/app_themes.dart';
import 'package:provicer_api_project/providers/product_provider.dart';
import 'package:provicer_api_project/views/product_form/product_form_screen.dart';

ListView ProductCard(ProductsProvider provider) {
  return ListView.builder(
    itemCount: provider.products.length,
    itemBuilder: (context, index) {
      final product = provider.products[index];
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Card(
          elevation: 5,
          color: AppColors.whiteColor,
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.fabBackground,
                        radius: 15,
                        child: Text(
                          "${index + 1}".toString(),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name ?? "Product Name",
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "PKR ${product.price ?? 0}".toString(),
                            style: TextStyle(
                              color: AppColors.fabBackground,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Divider(color: Colors.grey, thickness: 3),
                SizedBox(height: 10),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductFormScreen(product: product),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: AppColors.tileTitle,
                            size: 20,
                          ),

                          Text(
                            "EDIT",
                            style: TextStyle(
                              color: AppColors.tileTitle,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      GestureDetector(
                        onTap: () {
                          provider.deleteProduct(product.id!);
                        },
                        child: Row(
                          children: [
                             Icon(
                                Icons.delete,
                                color: AppColors.deleteIcon,
                                size: 20,
                              ),
                            
                            Text(
                              "DELETE",
                              style: TextStyle(
                                color: AppColors.deleteIcon,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                      
                    ],
                  ),
                ),
                SizedBox(height: 10),

              ],
              
            ),
          ),
        ),
      );
    },
  );
}
