import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../AnimalRegistry/index.dart';
import '../PreLogin/index.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _customTileExpanded = false;
  final FirebaseAuth authInstance = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Pedro'),
            accountEmail: const Text('pedro@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset('assets/ImagemTeste/ImagemDePerfil.jpeg'),
              ),
            ),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 136, 201, 191),
            ),
          ),
          ExpansionTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Atalhos'),
            textColor: const Color.fromARGB(255, 67, 67, 67),
            collapsedBackgroundColor: const Color.fromARGB(255, 254, 226, 155),
            //backgroundColor: const Color.fromARGB(255, 254, 226, 155),
            trailing: Icon(
              _customTileExpanded
                  ? Icons.arrow_drop_down
                  : Icons.arrow_drop_down,
            ),
            children: <Widget>[
              const Divider(
                endIndent: 100,
              ),
              ListTile(
                title: const Text('Cadastrar um pet'),
                onTap: () {
                  final User? user = authInstance.currentUser;
                  if (user == null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PreLoginScreen()),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AnimalRegistryScreen()),
                    );
                  }
                },
              ),
            ],
            onExpansionChanged: (bool expanded) {
              setState(() => _customTileExpanded = expanded);
            },
          ),
        ],
      ),
    );
  }
}
