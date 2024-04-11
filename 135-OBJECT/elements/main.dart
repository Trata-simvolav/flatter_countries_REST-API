import 'package:flutter/material.dart';
// import 'product_list_screen.dart';

import 'shopping_cart_screen.dart';
import 'product_class.dart';
import 'product_detail_screen.dart';
import 'product_searc_delegate.dart';
import 'filter_header.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProductListScreen(),
    );
  }
}

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  int _cartItemsCount = ShoppingCartScreen.cartItems.length;

  final List<String> _categories = [
    'Фрукты',
    'Овощи',
    'Орехи',
  ];

  String _selectedCategory = '';
  String _searchText = '';

  void _applyFilters(String category, String searchText) {
    setState(() {
      _selectedCategory = category;
      _searchText = searchText;
    });
  }

  void _resetFilters() {
    setState(() {
      _selectedCategory = '';
      _searchText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список товаров'),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ShoppingCartScreen(),
                    ),
                  );
                },
              ),
              _cartItemsCount > 0
                  ? Positioned(
                      right: 8,
                      top: 8,
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 10,
                        child: Text(
                          _cartItemsCount.toString(),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 196, 178, 178),
                              fontSize: 12),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final Product? selectedProduct = await showSearch(
                context: context,
                delegate: ProductSearchDelegate(),
              );

              if (selectedProduct != null) {
                // ignore: use_build_context_synchronously
                Navigator.push(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailsScreen(product: selectedProduct),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          ProductListHeader(
            categories: _categories,
            onCategorySelected: (category) {
              _applyFilters(category, _searchText);
            },
            onSearchTextChanged: (searchText) {
              _applyFilters(_selectedCategory, searchText);
            },
            onReset: () {
              _resetFilters();
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products.keys.toList()[index];
                if ((_selectedCategory.isNotEmpty &&
                        product.category != _selectedCategory) ||
                    (_searchText.isNotEmpty &&
                        !product.name
                            .toLowerCase()
                            .contains(_searchText.toLowerCase()))) {
                  return const SizedBox.shrink();
                }
                return ListTile(
                  leading: Image.asset(product.imageUrl),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name),
                      Text('Цена: \$${product.price.toString()}'),
                      Text('Дата публикации: ${product.publicationDate}'),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailsScreen(product: product),
                      ),
                    );
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      setState(() {
                        ShoppingCartScreen.cartItems.update(
                            product, (value) => value + 1,
                            ifAbsent: () => 1);
                        _cartItemsCount = ShoppingCartScreen.cartItems.length;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Товар добавлен в корзину'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
