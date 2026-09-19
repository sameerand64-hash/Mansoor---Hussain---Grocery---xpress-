import 'package:flutter/material.dart';

void main() {
  runApp(const GroceryExpressApp());
}

class GroceryExpressApp extends StatelessWidget {
  const GroceryExpressApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grocery Express',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> products = [
    {'name': 'Rice', 'price': 60, 'icon': Icons.rice_bowl},
    {'name': 'Milk', 'price': 55, 'icon': Icons.local_drink},
    {'name': 'Bread', 'price': 40, 'icon': Icons.bakery_dining},
    {'name': 'Eggs', 'price': 70, 'icon': Icons.egg},
    {'name': 'Apple', 'price': 120, 'icon': Icons.apple},
    {'name': 'Vegetables', 'price': 80, 'icon': Icons.eco},
  ];

  final List<Map<String, dynamic>> cart = [];

  void addToCart(Map<String, dynamic> product) {
    setState(() {
      cart.add(product);
    });

    Scaffold    

  
  
