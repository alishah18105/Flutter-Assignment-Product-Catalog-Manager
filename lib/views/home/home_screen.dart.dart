import 'package:flutter/material.dart';
import 'package:provicer_api_project/core/theme/app_themes.dart';
import 'package:provicer_api_project/providers/product_provider.dart';
import 'package:provicer_api_project/views/home/widgets/empty_state.dart';
import 'package:provicer_api_project/views/home/widgets/loading_state.dart';
import 'package:provicer_api_project/views/home/widgets/product_card.dart';
import 'package:provicer_api_project/views/product_form/product_form_screen.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ProductsProvider>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: AppColors.screenBackground,
        body: Padding(
          padding: const EdgeInsets.only(top: 25.0, left: 16, right: 16, bottom: 50),
          child: Column(
            children: [
              Row(
              children: [
                Text("Products", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30, color: AppColors.screenTitle),),
                Icon(Icons.shopify, size: 30, color: AppColors.blackColor,),
              ],
            ),
            SizedBox(height: 10,),
              Consumer<ProductsProvider>(
                builder: (context,provider,child) {
                  if (provider.isLoading) {
                      return LoadingState();
                      } 
                  else if(provider.isEmpty){
                    return EmptyState();
                  }
                  else{    
                  return Expanded(child: ProductCard(provider));
                }
                }
              ),
            ],
          ),
        ),
        
floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
  floatingActionButton: Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: FloatingActionButton.extended(
    backgroundColor: AppColors.fabBackground,
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductFormScreen(),
        ),
      );
    },
    icon: Icon(
      Icons.add,
      color: AppColors.whiteColor,
    ),
    label: Text(
      "ADD PRODUCT",
      style: TextStyle(
        color: AppColors.whiteColor,
        fontWeight: FontWeight.bold,
      ),
    ),
    ),
  ),
      );
    }

}