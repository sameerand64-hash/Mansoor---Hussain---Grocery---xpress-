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
      title: 'Mansoor Hussain Grocery Express',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF7F9F7),
      ),
      home: const HomePage(),
    );
  }
}

class Product {
  final String name;
  final String category;
  final String price;
  final String emoji;

  const Product({
    required this.name,
    required this.category,
    required this.price,
    required this.emoji,
  });
}

const products = [
  Product(name: 'Fresh Apples', category: 'Fruits', price: '₹120', emoji: '🍎'),
  Product(name: 'Bananas', category: 'Fruits', price: '₹60', emoji: '🍌'),
  Product(name: 'Tomatoes
