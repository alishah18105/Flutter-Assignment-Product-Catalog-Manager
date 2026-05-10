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
        appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Center(
            child: Row(
              children: [
                Text("Products", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25, color: AppColors.screenTitle),),
                Icon(Icons.shopify, size: 30, color: AppColors.screenTitle,)
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Consumer<ProductsProvider>(
            builder: (context,provider,child) {
              if (provider.isLoading) {
                  return LoadingState();
                  } 
              else if(provider.isEmpty){
                return EmptyState();
              }
              else{    
              return ProductCard(provider);
            }
            }
          ),
        ),
        floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,

  floatingActionButton: Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
    
        border: Border.all(
          color: AppColors.fabBackground,
          width: 1.5,
        ),
    
      ),
    
      child: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.transparent,
    
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductFormScreen()));
        },
    
        child: Icon(
          Icons.add,
          size: 34,
          color: AppColors.fabBackground,
        ),
      ),
    ),
  ),
      );
    }

}