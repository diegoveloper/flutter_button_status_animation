import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const HomeWidget(),
    );
  }
}

const _maxHeight = 100.0;
const _minHeight = 80.0;

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _small = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 850,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(
      Radius.circular(
        35,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final value = _small
                  ? Curves.elasticOut.transform(_controller.value)
                  : Curves.elasticIn.transform(_controller.value);
              final buttonColor = Color.lerp(
                Colors.black,
                Colors.white,
                value,
              );
              final textColor = Color.lerp(
                Colors.white,
                Colors.black,
                value,
              );
              final angle = lerpDouble(0, pi, value) ?? 0.0;
              final height = lerpDouble(_minHeight, _maxHeight, value);
              final textSizeTitle = lerpDouble(20, 25, value);
              final padding = EdgeInsets.lerp(
                  const EdgeInsets.all(20),
                  const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  value);
              final elevation = lerpDouble(10, 20, value)!;
              return Material(
                elevation: elevation,
                color: buttonColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: borderRadius,
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _small = !_small;
                    });
                    if (_small) {
                      _controller.forward(from: 0);
                    } else {
                      _controller.reverse(from: 1);
                    }
                  },
                  borderRadius: borderRadius,
                  child: Padding(
                    padding: padding!,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform.rotate(
                          angle: angle,
                          child: Image.network(
                            'https://cdn-icons-png.flaticon.com/512/1384/1384060.png',
                            height: 60,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Diego Velásquez',
                              style: TextStyle(
                                fontSize: textSizeTitle,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -1.1,
                                color: textColor,
                              ),
                            ),
                            const Text(
                              '@diegoveloper',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          const Text('Hello world'),
        ],
      )),
    );
  }
}
