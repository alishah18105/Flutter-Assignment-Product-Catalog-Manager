import 'package:flutter/material.dart';
import 'package:provicer_api_project/models/product.dart';
import 'package:provicer_api_project/providers/product_provider.dart';
import 'package:provicer_api_project/views/home/widgets/empty_state.dart';
import 'package:provicer_api_project/views/home/widgets/loading_state.dart';
import 'package:provicer_api_project/views/home/widgets/product_card.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
TextEditingController name = TextEditingController();
TextEditingController price = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
        appBar: AppBar(
          title: Text("Products"),
        ),
        body: Consumer<ProductsProvider>(
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Add Products"),
                  content: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: name,
                          decoration: InputDecoration(
                            label: Text("Name"),
                            filled: true,
                            fillColor: Colors.grey[350],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            prefixIcon: Icon(Icons.shopping_bag_outlined),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: price,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            label: Text("Price"),
                            filled: true,
                            fillColor: Colors.grey[350],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            prefixIcon: Icon(Icons.monetization_on_outlined),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async{
                        final item = Products(
                          name:  name.text,
                          price: double.parse(price.text)
                        );
                        await context.read<ProductsProvider>().createProduct(item);
                        name.clear();
                        price.clear();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
      );
    }

}