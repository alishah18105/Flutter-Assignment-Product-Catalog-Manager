import 'package:flutter/material.dart';
import 'package:provicer_api_project/providers/product_provider.dart';
import 'package:provicer_api_project/views/home/home_screen.dart.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> ProductsProvider())
      ],
      child: MaterialApp(
        title: "Product Catalog",
        debugShowCheckedModeBanner: false,
        home: HomeView(),
      ),) ;
  }
}