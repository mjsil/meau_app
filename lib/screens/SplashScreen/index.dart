import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import '../Login/index.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: <Widget>[
      AnimatedSplashScreen(
        duration: 1000,
        centered: true,
        splash: Container(),
        nextScreen: const LoginScreen(),
      ),
      Scaffold(
        backgroundColor: const Color.fromRGBO(136, 201, 191, 1),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/SpashScreenImage/Meau_malha.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 276,
                          height: 100,
                          child: Image.asset(
                              'assets/SpashScreenImage/Meau_marca.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
