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
                  top: 50,
                  child: Image.asset(
                    "assets/dish.png",
                    height: 215,
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
                      height: 300,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
