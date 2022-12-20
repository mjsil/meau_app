
import 'package:flutter/material.dart';
import 'package:meau_app/screens/Introduction/index.dart';
import 'package:meau_app/screens/SplashScreen/index.dart';
import 'package:meau_app/services/auth/index.dart';
import 'package:provider/provider.dart';

import 'models/user/index.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<User?> snapshot) {
        if(snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          
          return user == null ? const IntroScreen() : const IntroductionScreen();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      }
    );
  }
}