class Topping {
  final String name;
  final String imageUrl;
  final int price;
  Topping({required this.name, required this.imageUrl, required this.price});

  static final mock = [
    Topping(name: 'Chili', imageUrl: 'assets/chili_unit.png', price: 1),
    Topping(name: 'Mushroom', imageUrl: 'assets/mushroom_unit.png', price: 1),
    Topping(name: 'Olive', imageUrl: 'assets/olive_unit.png', price: 1),
    Topping(name: 'Onion', imageUrl: 'assets/onion.png', price: 1),
    Topping(name: 'Pea', imageUrl: 'assets/pea_unit.png', price: 1),
    Topping(name: 'Pickle', imageUrl: 'assets/pickle_unit.png', price: 1),
    Topping(name: 'Potato', imageUrl: 'assets/potato_unit.png', price: 1),
  ];
}
