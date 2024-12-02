class Topping {
  final String name;
  final String imageUrl;

  Topping({required this.name, required this.imageUrl});

  static final mock = [
    Topping(name: 'Chili', imageUrl: 'assets/chili_unit.png'),
    Topping(name: 'Mushroom', imageUrl: 'assets/mushroom_unit.png'),
    Topping(name: 'Olive', imageUrl: 'assets/olive_unit.png'),
    Topping(name: 'Onion', imageUrl: 'assets/onion.png'),
    Topping(name: 'Pea', imageUrl: 'assets/pea_unit.png'),
    Topping(name: 'Pickle', imageUrl: 'assets/pickle_unit.png'),
    Topping(name: 'Potato', imageUrl: 'assets/potato_unit.png'),
  ];
}
