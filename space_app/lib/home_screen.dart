import 'dart:async';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  double shipX = 0.0, shipY = 0.0;
  double maxHeight = 0.0;
  double initialPos = 0.0;
  double time = 0.0;
  double velocity = 2.9;
  double gravity = -4.9;
  bool isGameRun = false;

  void startGame() {
    isGameRun = true;
    Timer.periodic(
      const Duration(
        milliseconds: 30
      ),
      (timer) {
        time = time + 0.02;
        setState(() {
          maxHeight = velocity * time + gravity * time * time;
          shipY = initialPos - maxHeight;
        });
      }
    );
  }

  void onJump() {
    setState(() {
      time = 0;
      initialPos = shipY;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: isGameRun ? onJump : startGame,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/space.png',
              ),
              fit: BoxFit.cover
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment(shipX,shipY),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/ship.png'
                      ),
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
