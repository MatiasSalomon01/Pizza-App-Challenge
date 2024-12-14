import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app_challenge/models/pizza_item.dart';
import 'package:pizza_app_challenge/models/topping.dart';
import 'package:pizza_app_challenge/screens/home_screens.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.index, required this.item});
  final int index;
  final PizzaItem item;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<Widget> ingredients = [];
  GlobalKey stackKey = GlobalKey();
  Offset getRelativeOffset(Offset globalOffset) {
    final RenderBox stackBox =
        stackKey.currentContext?.findRenderObject() as RenderBox;

    return stackBox.globalToLocal(globalOffset);
  }

  int price = 0;
  @override
  void initState() {
    super.initState();
    price = widget.item.price;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.brown),
        centerTitle: true,
        title: Text(
          widget.item.name,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 30),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .75,
                child: Stack(
                  children: [
                    Hero(
                      tag: 'background',
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * .1),
                        height: MediaQuery.of(context).size.height * .73,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xfff9f7f2),
                              Colors.white,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          // border: Border.all(color: Colors.black87),
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: MediaQuery.of(context).size.width * .44,
                      right: MediaQuery.of(context).size.width * .44,
                      child: Hero(
                        tag: 'cart',
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 15,
                                  offset: Offset(0, 10),
                                  spreadRadius: -4,
                                  color: Color(0xfff17e3a),
                                  // color: Colors.red,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(8),
                              gradient: const LinearGradient(
                                colors: [Color(0xffedc75b), Color(0xfff17e3a)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              )),
                          child: Image.asset(
                            "assets/cart.png",
                            height: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * .38,
              right: MediaQuery.of(context).size.width * .38,
              top: 215,
              child: Container(
                height: 25,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ),
            ),
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
              child: Column(
                children: [
                  Hero(
                    tag: 'pizza-${widget.index}',
                    child: DragTarget(
                      onAcceptWithDetails: (data) {
                        Offset localOffset = getRelativeOffset(data.offset);
                        var asd = MediaQuery.of(context).size.width * .25;
                        var asdd = MediaQuery.of(context).size.width * .65;
                        if (asd <= localOffset.dx && localOffset.dx <= asdd) {
                          var left = localOffset.dx - 5;
                          var top = localOffset.dy - 5;
                          var asd = Positioned(
                            left: left,
                            top: top,
                            child: SizedBox(
                              height: 30,
                              child: Image.asset(
                                Topping.mock[data.data as int].imageUrl,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          );
                          ingredients.add(asd);
                          price += Topping.mock[data.data as int].price;
                          setState(() {});
                        }
                      },
                      builder: (context, candidateData, rejectedData) => Stack(
                        key: stackKey,
                        children: [
                          Container(
                            height: 230,
                            margin: const EdgeInsets.only(top: 12),
                            decoration: BoxDecoration(
                              // color: Colors.red,
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/pizza-${widget.index}.png"),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          ...ingredients,
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  FadeInUp(
                    key: ValueKey('$price'),
                    from: 10,
                    duration: const Duration(milliseconds: 200),
                    child: Hero(
                      tag: '${widget.item.name}-price',
                      child: Text(
                        '\$$price',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: 40, fontFamily: 'RozhaOne'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Buttons(),
                  const SizedBox(height: 35),
                  Text(
                    'Toppings (must be 2)',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 25),
                  SlideInUp(
                    duration: const Duration(milliseconds: 500),
                    // from: 1000,
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .1),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: Topping.mock.length,
                        itemBuilder: (context, index) => Draggable(
                          data: index,
                          feedback: Image.asset(
                            Topping.mock[index].imageUrl,
                            fit: BoxFit.fitHeight,
                            height: 30,
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xfff9f7f2),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black87.withOpacity(.1),
                              ),
                            ),
                            child: Image.asset(
                              Topping.mock[index].imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(width: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
