import 'package:flutter/material.dart';
import 'package:provicer_api_project/providers/product_povider.dart';
import 'package:provicer_api_project/screens/HomeScreen.dart/homeView.dart';
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
        home: HomeView(),
      ),) ;
  }
}