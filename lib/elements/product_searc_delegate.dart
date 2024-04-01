import 'package:flutter/material.dart';
import 'product_class.dart';

class ProductSearchDelegate extends SearchDelegate<Product> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        // Возвращаем пустой Product, если нажата кнопка назад
        close(
            context,
            const Product(
                name: '',
                imageUrl: '',
                price: 0.0,
                category: '',
                publicationDate: '',
                description: ''));
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView(
      children: products.keys
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .map((product) => ListTile(
                title: Text(product.name),
                onTap: () {
                  close(context, product);
                },
              ))
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? products.keys.toList()
        : products.keys
            .where((product) =>
                product.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        final product = suggestionList[index];
        return ListTile(
          title: Text(product.name),
          onTap: () {
            query = product.name;
            showResults(context);
          },
        );
      },
    );
  }
}
