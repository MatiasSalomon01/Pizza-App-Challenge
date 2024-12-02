import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app_challenge/models/pizza_item.dart';
import 'package:pizza_app_challenge/screens/details_screen.dart';
import 'package:pizza_app_challenge/utils/custom_page_view_scroll_physics.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final PageController controller;
  late final AnimationController dataController;
  int currentIndex = 0;
  bool animate = true;
  @override
  void initState() {
    super.initState();
    controller = PageController(viewportFraction: .5)
      ..addListener(() {
        setState(() {});
      });
    // dataController =
    //     AnimationController(vsync: this, duration: Duration(microseconds: 400))
    //       ..addListener(() {
    //         setState(() {});
    //       });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Mannually',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontFamily: 'Header', fontSize: 35),
            ),
            Row(
              children: [
                const Icon(Icons.pin_drop, size: 15, color: Colors.brown),
                const SizedBox(width: 8),
                Text(
                  'Washington Park',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(50)),
              child: Text(
                'Pizza',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    letterSpacing: .5,
                    fontFamily: 'Impact'),
              ),
            ),
            Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 150,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .47,
                    child: Stack(
                      children: [
                        Hero(
                          tag: 'background',
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * .25),
                            height: MediaQuery.of(context).size.height * .45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.black87.withOpacity(.1)),
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(200),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: MediaQuery.of(context).size.width * .44,
                          right: MediaQuery.of(context).size.width * .44,
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
                                  colors: [
                                    Color(0xffedc75b),
                                    Color(0xfff17e3a)
                                  ],
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
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 50,
                  child: Hero(
                    tag: 'plate',
                    child: Image.asset(
                      "assets/dish.png",
                      height: 215,
                    ),
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * .38,
                  right: MediaQuery.of(context).size.width * .38,
                  top: 230,
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
                  top: 12,
                  child: Transform.rotate(
                    angle: !controller.hasClients
                        ? 0
                        : controller.page! * .5 * 3.14159265359,
                    child: Image.asset(
                      "assets/circle-salad.png",
                      height: 280,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  child: PageView.builder(
                    physics: const CustomPageViewScrollPhysics(),
                    controller: controller,
                    itemCount: 9,
                    onPageChanged: (value) {
                      setState(() {
                        currentIndex = value;
                        animate = true;
                      });
                    },
                    itemBuilder: (context, index) {
                      return AnimatedBuilder(
                        animation: controller,
                        builder: (context, child) {
                          // Calcula la posición relativa de la página
                          double value = 0.0;

                          // Verifica si las dimensiones están disponibles
                          if (controller.hasClients &&
                              controller.position.hasPixels &&
                              controller.position.hasContentDimensions) {
                            value = controller.page! - index;
                          } else {
                            value = index.toDouble();
                          }

                          // Calcula el desplazamiento Y
                          double verticalOffset =
                              (1 - value.abs()).clamp(0.0, 1.0) *
                                  -MediaQuery.of(context).size.height *
                                  .207;

                          return Transform.scale(
                            scale: (1 - value.abs()).clamp(.5, 1),
                            child: Transform.translate(
                              offset: Offset(0, verticalOffset),
                              child: Transform.rotate(
                                angle: value * .5 * 3.14159265359,
                                child: child,
                              ),
                            ),
                          );
                        },
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                    index: currentIndex,
                                    item: PizzaItem.mock[currentIndex]),
                              ),
                            );
                          },
                          child: Hero(
                            tag: 'pizza-$index',
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/pizza-$index.png"),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Details(item: PizzaItem.mock[currentIndex]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Details extends StatefulWidget {
  const Details({
    super.key,
    required this.item,
  });

  final PizzaItem item;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool isSmall = false;
  bool isMedium = true;
  bool isLarge = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .56,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FadeInUp(
            key: ValueKey(widget.item.name),
            from: 10,
            duration: const Duration(milliseconds: 200),
            child: Text(
              widget.item.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              var rating = widget.item.rating;

              // Determina el tipo de estrella a mostrar
              IconData icon;
              if (index < rating.floor()) {
                // Estrella completa
                icon = Icons.star;
              } else if (index < rating && rating - index == 0.5) {
                // Estrella media
                icon = Icons.star_half;
              } else {
                // Estrella vacía
                icon = Icons.star_border;
              }

              return Icon(
                icon,
                color: const Color(0xffDC9639),
                size: 15,
              );
            }),
          ),
          FadeInUp(
            key: ValueKey('${widget.item.name}-price'),
            from: 10,
            duration: const Duration(milliseconds: 200),
            child: Text(
              '\$${widget.item.price}',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 40, fontFamily: 'RozhaOne'),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  shape: const WidgetStatePropertyAll(CircleBorder()),
                  elevation: WidgetStatePropertyAll(isSmall ? 5 : 0),
                  overlayColor:
                      const WidgetStatePropertyAll(Colors.transparent),
                  backgroundColor: const WidgetStatePropertyAll(Colors.white),
                ),
                onPressed: () => setState(() {
                  isSmall = true;
                  isMedium = false;
                  isLarge = false;
                }),
                child: Text(
                  'S',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  shape: const WidgetStatePropertyAll(CircleBorder()),
                  elevation: WidgetStatePropertyAll(isMedium ? 5 : 0),
                  overlayColor:
                      const WidgetStatePropertyAll(Colors.transparent),
                  backgroundColor: const WidgetStatePropertyAll(Colors.white),
                ),
                onPressed: () => setState(() {
                  isSmall = false;
                  isMedium = true;
                  isLarge = false;
                }),
                child: Text(
                  'M',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  shape: const WidgetStatePropertyAll(CircleBorder()),
                  elevation: WidgetStatePropertyAll(isLarge ? 5 : 0),
                  overlayColor:
                      const WidgetStatePropertyAll(Colors.transparent),
                  backgroundColor: const WidgetStatePropertyAll(Colors.white),
                ),
                onPressed: () => setState(() {
                  isSmall = false;
                  isMedium = false;
                  isLarge = true;
                }),
                child: Text(
                  'L',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
