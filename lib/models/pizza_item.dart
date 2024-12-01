class PizzaItem {
  final String name;
  final int price;
  final double rating;

  PizzaItem({required this.name, required this.price, required this.rating});

  static final List<PizzaItem> mock = [
    PizzaItem(name: 'Margarita', price: 15, rating: 4.5),
    PizzaItem(name: 'Pepperoni', price: 20, rating: 4.0),
    PizzaItem(name: 'Hawaiana', price: 18, rating: 3.5),
    PizzaItem(name: 'Cuatro Quesos', price: 25, rating: 5.0),
    PizzaItem(name: 'Vegetariana', price: 22, rating: 4.5),
    PizzaItem(name: 'Barbacoa', price: 28, rating: 4.0),
    PizzaItem(name: 'Mexicana', price: 30, rating: 3.0),
    PizzaItem(name: 'Carbonara', price: 24, rating: 3.5),
    PizzaItem(name: 'Napolitana', price: 14, rating: 2.5),
    PizzaItem(name: 'Marinera', price: 12, rating: 2.0),
  ];
}
