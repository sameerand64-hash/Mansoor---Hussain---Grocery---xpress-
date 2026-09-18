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
        scaffoldBackgroundColor: const Color(0xfff7f9f7),
      ),
      home: const HomePage(),
    );
  }
}

class Product {
  final String name;
  final String category;
  final String emoji;
  final double price;

  const Product({
    required this.name,
    required this.category,
    required this.emoji,
    required this.price,
  });
}

const products = [
  Product(
    name: 'Fresh Apples',
    category: 'Fruits',
    emoji: '🍎',
    price: 120,
  ),
  Product(
    name: 'Banana',
    category: 'Fruits',
    emoji: '🍌',
    price: 60,
  ),
  Product(
    name: 'Fresh Milk',
    category: 'Dairy',
    emoji: '🥛',
    price: 65,
  ),
  Product(
    name: 'Bread',
    category: 'Bakery',
    emoji: '🍞',
    price: 45,
  ),
  Product(
    name: 'Basmati Rice',
    category: 'Grocery',
    emoji: '🍚',
    price: 180,
  ),
  Product(
    name: 'Cooking Oil',
    category: 'Grocery',
    emoji: '🫗',
    price: 150,
  ),
  Product(
    name: 'Tomatoes',
    category: 'Vegetables',
    emoji: '🍅',
    price: 50,
  ),
  Product(
    name: 'Potatoes',
    category: 'Vegetables',
    emoji: '🥔',
    price: 40,
  ),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Product> cart = [];
  int selectedCategory = 0;

  final categories = [
    {'name': 'All', 'icon': Icons.apps},
    {'name': 'Fruits', 'icon': Icons.apple},
    {'name': 'Vegetables', 'icon': Icons.eco},
    {'name': 'Dairy', 'icon': Icons.local_drink},
    {'name': 'Bakery', 'icon': Icons.bakery_dining},
    {'name': 'Grocery', 'icon': Icons.shopping_basket},
  ];

  List<Product> get filteredProducts {
    if (selectedCategory == 0) {
      return products;
    }

    final category = categories[selectedCategory]['name'];

    return products
        .where((product) => product.category == category)
        .toList();
  }

  double get total {
    return cart.fold(0, (sum, product) => sum + product.price);
  }

  void addToCart(Product product) {
    setState(() {
      cart.add(product);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} cart mein add ho gaya'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void openCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CartPage(cart: cart),
      ),
    ).then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mansoor Hussain',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Grocery Express',
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: openCart,
                icon: const Icon(Icons.shopping_cart),
              ),
              if (cart.isNotEmpty)
                Positioned(
                  right: 5,
                  top: 5,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${cart.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.shade700,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fresh Groceries 🛒',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Ghar baithe grocery order karein',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Fast • Fresh • Reliable',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                hintText: 'Search groceries...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 22),

            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 105,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final selected = selectedCategory == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = index;
                      });
                    },
                    child: Container(
                      width: 82,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: selected
                            ? Colors.green
                            : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: selected
                              ? Colors.green
                              : Colors.grey.shade200,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            category['icon'] as IconData,
                            color: selected
                                ? Colors.white
                                : Colors.green,
                            size: 30,
                          ),
                          const SizedBox(height: 7),
                          Text(
                            category['name'] as String,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: selected
                                  ? Colors.white
                                  : Colors.black87,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 22),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Popular Products',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${filteredProducts.length} items',
                  style: TextStyle(
                    color: Colors.green.shade700,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredProducts.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.72,
              ),
              itemBuilder: (context, index) {
                final product = filteredProducts[index];

                return ProductCard(
                  product: product,
                  onAdd: () => addToCart(product),
                );
              },
            ),

            const SizedBox(height: 20),

            if (cart.isNotEmpty)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: openCart,
                  icon: const Icon(Icons.shopping_cart),
                  label: Text(
                    'View Cart • ₹${total.toStringAsFixed(0)}',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAdd;

  const ProductCard({
    super.key,
    required this.product,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Text(
                product.emoji,
                style: const TextStyle(fontSize: 65),
              ),
            ),
          ),
          Text(
            product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            product.category,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₹${product.price.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: onAdd,
                style: IconButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  final List<Product> cart;

  const CartPage({
    super.key,
    required this.cart,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double get total {
    return widget.cart.fold(
      0,
      (sum, product) => sum + product.price,
    );
  }

  void checkout() {
    if (widget.cart.isEmpty) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CheckoutPage(total: total),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: widget.cart.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Cart empty hai',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: widget.cart.length,
                    itemBuilder: (context, index) {
                      final product = widget.cart[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          leading: Text(
                            product.emoji,
                            style: const TextStyle(fontSize: 35),
                          ),
                          title: Text(product.name),
                          subtitle: Text(product.category),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '₹${product.price.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    widget.cart.removeAt(index);
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '₹${total.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize:
