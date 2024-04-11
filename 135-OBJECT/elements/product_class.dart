class Product {
  final String name;
  final String imageUrl;
  final double price;
  final String category;
  final String publicationDate;
  final String description;

  const Product({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.category,
    required this.publicationDate,
    required this.description,
  });
}

Map<Product, int> products = {
  const Product(
    name: 'Яблоко',
    description: 'Сорт Делишес (Red Delicious)',
    imageUrl: 'assets/apple.jpg',
    price: 680,
    category: 'Фрукты',
    publicationDate: '2024-03-16',
  ): 0,
  const Product(
    name: 'Киви',
    description: 'Свежий и сочный киви из Австрий.',
    imageUrl: 'assets/kivi.jpg',
    price: 1090,
    category: 'Фрукты',
    publicationDate: '2024-03-17',
  ): 0,
  const Product(
    name: 'Банан',
    description: 'Сорт "Кавендиш".',
    imageUrl: 'assets/banana.jpg',
    price: 923,
    category: 'Фрукты',
    publicationDate: '2024-03-17',
  ): 0,
  const Product(
    name: 'Груша',
    description: 'Сорта "Бартлетт"',
    imageUrl: 'assets/pear.jpg',
    price: 645,
    category: 'Фрукты',
    publicationDate: '2024-03-19',
  ): 0,
  const Product(
    name: 'Картошка',
    description: 'Сорт "Ред Руссет".',
    imageUrl: 'assets/potato.jpg',
    price: 160,
    category: 'Овощи',
    publicationDate: '2024-03-10',
  ): 0,
  const Product(
    name: 'Морковь',
    description: 'Сорт "Нантская".',
    imageUrl: 'assets/carrot.jpg',
    price: 195,
    category: 'Овощи',
    publicationDate: '2024-03-09',
  ): 0,
  const Product(
    name: 'Капуста',
    description: 'Сорт "Белокачанная".',
    imageUrl: 'assets/cabbage.jpg',
    price: 190,
    category: 'Овощи',
    publicationDate: '2024-03-18',
  ): 0,
  const Product(
    name: 'Миндаль',
    description:
        'Испанского происхождения идеально подходит для употребления в свежем виде.',
    imageUrl: 'assets/almond.jpg',
    price: 3500,
    category: 'Орехи',
    publicationDate: '2024-03-07',
  ): 0,
  const Product(
    name: 'Фундук',
    description: 'Одомашненный лесной орех.',
    imageUrl: 'assets/hazelnut.jpg',
    price: 6000,
    category: 'Орехи',
    publicationDate: '2024-03-17',
  ): 0,
};
