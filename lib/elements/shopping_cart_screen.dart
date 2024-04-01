import 'package:flutter/material.dart';
import 'product_class.dart';

class ShoppingCartScreen extends StatefulWidget {
  static Map<Product, int> cartItems = {};

  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  double _totalPrice = 0;

  @override
  void initState() {
    super.initState();
    _calculateTotalPrice();
  }

  void _calculateTotalPrice() {
    double total = 0;
    for (var entry in ShoppingCartScreen.cartItems.entries) {
      total += entry.key.price * entry.value;
    }
    setState(() {
      _totalPrice = total;
    });
  }

  void _clearCart() {
    setState(() {
      ShoppingCartScreen.cartItems.clear();
      _totalPrice = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Очистить корзину?'),
                  content: const Text(
                      'Вы уверены, что хотите удалить все товары из корзины?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Отмена'),
                    ),
                    TextButton(
                      onPressed: () {
                        _clearCart();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Очистить'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: ShoppingCartScreen.cartItems.length,
        itemBuilder: (context, index) {
          final product = ShoppingCartScreen.cartItems.keys.toList()[index];
          var quantity = ShoppingCartScreen.cartItems[product]!;
          return ListTile(
            leading: Image.asset(product.imageUrl),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name),
                Text('Цена за единицу: \$${product.price}'),
                Text('Общая цена: \$${product.price * quantity}'),
              ],
            ),
            subtitle: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (quantity > 1) {
                        quantity--;
                        ShoppingCartScreen.cartItems[product] = quantity;
                        _calculateTotalPrice();
                      }
                    });
                  },
                ),
                Text('($quantity шт.)'),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      quantity++;
                      ShoppingCartScreen.cartItems[product] = quantity;
                      _calculateTotalPrice();
                    });
                  },
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Удалить товар из корзины?'),
                    content: Text(
                        'Вы уверены, что хотите удалить ${product.name} из корзины?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Отмена'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            ShoppingCartScreen.cartItems.remove(product);
                            _calculateTotalPrice();
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Text('Удалить'),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Итого: \$$_totalPrice'),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Оформить заказ'),
            ),
          ],
        ),
      ),
    );
  }
}
