import 'package:flutter/material.dart';

class ProductListHeader extends StatelessWidget {
  final List<String> categories;
  final Function(String) onCategorySelected;
  final Function(String) onSearchTextChanged;
  final Function() onReset;

  const ProductListHeader({
    super.key,
    required this.categories,
    required this.onCategorySelected,
    required this.onSearchTextChanged,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DropdownButton<String>(
              value: null,
              hint: const Text('Выберите категорию'),
              items: categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                onCategorySelected(value ?? '');
              },
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: onReset,
            ),
          ],
        ),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Поиск',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (value) {
            onSearchTextChanged(value);
          },
        ),
      ],
    );
  }
}
