import 'package:flutter/material.dart';
import 'package:pizza_app_challenge/utils/custom_page_view_scroll_physics.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController controller;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = PageController(viewportFraction: .5)
      ..addListener(() {
        setState(() {});
      });
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
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 5),
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
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w900),
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
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * .25),
                          height: MediaQuery.of(context).size.height * .45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(200),
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
                  child: Image.asset(
                    "assets/dish.png",
                    height: 215,
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
                      setState(() => currentIndex = value);
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
                        child: Container(
                          // margin: const EdgeInsets.symmetric(horizontal: 10),
                          // margin: EdgeInsets.only(top: 120),
                          decoration: BoxDecoration(
                            // color: Colors.red,
                            // borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage("assets/pizza-$index.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .56,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Pizza',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          5,
                          (index) => const Icon(
                            Icons.star,
                            color: Color(0xffDC9639),
                            size: 15,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '\$12',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 35),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: const ButtonStyle(
                              shape: WidgetStatePropertyAll(CircleBorder()),
                              elevation: WidgetStatePropertyAll(0),
                              overlayColor:
                                  WidgetStatePropertyAll(Colors.transparent),
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.white),
                            ),
                            onPressed: () {},
                            child: Text(
                              'S',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                          ElevatedButton(
                            style: const ButtonStyle(
                              shape: WidgetStatePropertyAll(CircleBorder()),
                              elevation: WidgetStatePropertyAll(5),
                              overlayColor:
                                  WidgetStatePropertyAll(Colors.transparent),
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.white),
                            ),
                            onPressed: () {},
                            child: Text(
                              'M',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                          ElevatedButton(
                            style: const ButtonStyle(
                              shape: WidgetStatePropertyAll(CircleBorder()),
                              elevation: WidgetStatePropertyAll(0),
                              overlayColor:
                                  WidgetStatePropertyAll(Colors.transparent),
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.white),
                            ),
                            onPressed: () {},
                            child: Text(
                              'L',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
