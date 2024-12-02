import 'package:flutter/material.dart';
import 'package:pizza_app_challenge/models/pizza_item.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.index, required this.item});
  final int index;
  final PizzaItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.brown),
        centerTitle: true,
        title: Text(
          item.name,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 30),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Hero(
                tag: 'plate',
                child: Image.asset(
                  "assets/dish.png",
                  height: 250,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Hero(
                tag: 'pizza-$index',
                child: Container(
                  height: 230,
                  margin: const EdgeInsets.only(top: 13),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/pizza-$index.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // Hero(
      //   tag: 'background',
      //   child: Container(
      //     margin: EdgeInsets.symmetric(
      //         horizontal: MediaQuery.of(context).size.width * .25),
      //     height: MediaQuery.of(context).size.height * .45,
      //     decoration: BoxDecoration(
      //       color: Colors.white,
      //       border: Border.all(color: Colors.black87.withOpacity(.1)),
      //       borderRadius: const BorderRadius.vertical(
      //         bottom: Radius.circular(200),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
