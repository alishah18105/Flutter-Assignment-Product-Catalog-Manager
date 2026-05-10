import 'package:flutter/material.dart';
import 'package:provicer_api_project/model/products.model.dart';
import 'package:provicer_api_project/providers/product_povider.dart';
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
      context.read<ProductsProvider>().fetchApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductsProvider>();

    if (provider.isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    } else {
      return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
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
                      provider.updateProducts(item);
                    },
                    icon: Icon(Icons.edit),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      provider.deleteProducts(product.id!);
                    },
                    icon: Icon(Icons.delete),
                  ),
                ],
              ),
            );
          },
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
                          price: int.parse(price.text)
                        );
                        await provider.addProducts(item);
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
}
