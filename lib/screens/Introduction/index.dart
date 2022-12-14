import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../services/auth/index.dart';
import '../AdoptAnimal/index.dart';
import '../AnimalRegistry/index.dart';
import '../MyAnimals/index.dart';
import '../SideBarMenu/index.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 136, 201, 191)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: const NavBar(),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 56),
            const Text(
              "Olá",
              style: TextStyle(
                fontSize: 72.0,
                fontFamily: 'Courgette',
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 255, 211, 88),
              ),
            ),
            const SizedBox(height: 52),
            const Text(
              '''Bem vindo ao Meau! \n Aqui você pode adotar, doar e ajudar \n cães e gatos com facilidade. \n Qual o seu interesse?''',
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 117, 117, 117),
              ),
            ),
            //ADOPT
            const SizedBox(height: 48),
            Container(
              alignment: Alignment.center,
              width: 232.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 211, 88),
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdoptAnimal()),
                  ),
                  child: const SizedBox(
                    width: 232.0,
                    height: 40.0,
                    child: Center(
                      child: Text(
                        "ADOTAR",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 67, 67, 67),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            //HELP
            Container(
              alignment: Alignment.center,
              width: 232.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 211, 88),
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyAnimalsScreen()),
                  ),
                  child: const SizedBox(
                    width: 232.0,
                    height: 40.0,
                    child: Center(
                      child: Text(
                        "MEUS ANIMAIS",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 67, 67, 67),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            //ANIMAL REGISTRY
            Container(
              alignment: Alignment.center,
              width: 232.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 211, 88),
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AnimalRegistryScreen()),
                  ),
                  child: const SizedBox(
                    width: 232.0,
                    height: 40.0,
                    child: Center(
                      child: Text(
                        "CADASTRAR ANIMAL",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 67, 67, 67),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //Login button
            const SizedBox(height: 44),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              onPressed: () => authService.signOut(),
              child: const Text(
                "SAIR",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 136, 201, 191),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
