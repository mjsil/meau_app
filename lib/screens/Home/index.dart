//não usado
import 'package:flutter/material.dart';

import '../AllAnimals/index.dart';
import '../AnimalRegistry/index.dart';
import '../MyAnimals/index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.email,
  });
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adotar'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(children: <Widget>[
          const SizedBox(height: 20),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.black,
              textStyle: const TextStyle(
                fontSize: 12,
              ),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyAnimalsScreen(user: (email))),
            ),
            child: const Text("MEUS ANIMAIS"),
          ),
          const SizedBox(height: 20),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.black,
              textStyle: const TextStyle(
                fontSize: 12,
              ),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AnimalsScreen()),
            ),
            child: const Text("ADOTAR ANIMAL"),
          ),
          const SizedBox(height: 100),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.black,
              textStyle: const TextStyle(
                fontSize: 12,
              ),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AnimalRegistryScreen()),
            ),
            child: const Text("CADASTRAR ANIMAL"),
          ),
        ]),
      ),
    );
  }
}
