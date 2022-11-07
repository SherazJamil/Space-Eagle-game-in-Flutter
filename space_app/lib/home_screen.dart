import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'asteroid_model.dart';

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

  List<AsteroidDetail> asteroidDetail = [];

    List<AsteroidDetail> setAsteroidDetail() {
    List<AsteroidDetail> data = [
      AsteroidDetail(
          size: const Size(40, 60),
          alignment: const Alignment(2, 0.7),
      ),
      AsteroidDetail(
        size: const Size(80, 100),
        alignment: const Alignment(1.5, -0.5),
      ),
      AsteroidDetail(
        size: const Size(40, 50),
        alignment: const Alignment(3, -0.2),
      ),
      AsteroidDetail(
        size: const Size(60, 30),
        alignment: const Alignment(2.2, 0.2),
      ),
    ];
    return data;
    }

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
          if(isShipColide()) {
            timer.cancel();
          }
        });
        moveAst();
      }
    );
  }

  void onJump() {
    setState(() {
      time = 0;
      initialPos = shipY;
    });
  }

  double generateRndmNmbr () {
      Random rand = Random();
      double randomDouble = rand.nextDouble() * (-1.0 - 1.0) + 1.0;
      return randomDouble;
  }

  void moveAst() {
      Alignment ast1 = asteroidDetail[0].alignment;
      Alignment ast2 = asteroidDetail[1].alignment;
      Alignment ast3 = asteroidDetail[2].alignment;
      Alignment ast4 = asteroidDetail[3].alignment;

      if(ast1.x > -1.4) {
        asteroidDetail[0].alignment = Alignment(ast1.x - 0.02, ast1.y);
      } else {
        asteroidDetail[0].alignment = Alignment(2, generateRndmNmbr());
      }
      if(ast2.x > -1.4) {
        asteroidDetail[1].alignment = Alignment(ast2.x - 0.02, ast2.y);
      } else {
        asteroidDetail[1].alignment = Alignment(1.5, generateRndmNmbr());
      }
      if(ast3.x > -1.4) {
        asteroidDetail[2].alignment = Alignment(ast3.x - 0.02, ast3.y);
      } else {
        asteroidDetail[2].alignment = Alignment(3, generateRndmNmbr());
      }
      if(ast4.x > -1.4) {
        asteroidDetail[3].alignment = Alignment(ast4.x - 0.02, ast4.y);
      } else {
        asteroidDetail[3].alignment = Alignment(2.2, generateRndmNmbr());
      }
  }

  bool isShipColide() {
      if(shipY > 1) {
        return true;
      }
      else if(shipY < -0.95) {
        return true;
      }
      else {
        return false;
      }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    asteroidDetail = setAsteroidDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
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
                          'assets/ship1.png'
                        ),
                      )
                    ),
                  ),
                ),
                Align(
                  alignment: asteroidDetail[0].alignment,
                  child: Container(
                    height: asteroidDetail[0].size.height,
                    width: asteroidDetail[0].size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          asteroidDetail[0].path
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: asteroidDetail[1].alignment,
                  child: Container(
                    height: asteroidDetail[1].size.height,
                    width: asteroidDetail[1].size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            asteroidDetail[1].path
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: asteroidDetail[2].alignment,
                  child: Container(
                    height: asteroidDetail[2].size.height,
                    width: asteroidDetail[2].size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            asteroidDetail[2].path
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: asteroidDetail[3].alignment,
                  child: Container(
                    height: asteroidDetail[3].size.height,
                    width: asteroidDetail[3].size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            asteroidDetail[3].path
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0, -0.3),
                  child: Text(
                    'Tap to Play',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
