import 'package:flutter/material.dart';

import '../AnimalRegistry/index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adotar'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: 232,
            height: 40,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.black,
                textStyle: const TextStyle(
                  fontSize: 12,
                ),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AnimalRegistryScreen()),
              ),
              child: const Text("CADASTRAR ANIMAL"),
            ),
          ),
        ),
      ), 
    );
  }
}