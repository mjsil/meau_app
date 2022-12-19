import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Login/index.dart';
import '../SignUp/index.dart';

//PreLoginScreen

class PreLoginScreen extends StatelessWidget {
  const PreLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 250, 250, 250),
        appBar: AppBar(
          title: const Text(
            "Cadastro",
            style: TextStyle(
              color: Color.fromARGB(255, 67, 67, 67),
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
            ),
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Color.fromARGB(255, 255, 211, 88)),
          iconTheme:
              const IconThemeData(color: Color.fromARGB(255, 67, 67, 67)),
          backgroundColor: const Color.fromARGB(255, 136, 201, 191),
          elevation: 0,
        ),
        body: const PreLogin());
  }
}

class PreLogin extends StatefulWidget {
  const PreLogin({super.key});

  @override
  State<PreLogin> createState() => _PreLoginState();
}

class _PreLoginState extends State<PreLogin> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 52),
          const Text(
            "Ops!",
            style: TextStyle(
              fontSize: 72.0,
              fontFamily: 'Courgette',
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 136, 201, 191),
            ),
          ),
          const SizedBox(height: 52),
          const Text(
            '''Você não pode realizar esta ação sem\npossuir um cadastro.''',
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 117, 117, 117),
            ),
          ),
          const SizedBox(height: 16),
          //register
          Container(
            alignment: Alignment.center,
            width: 232.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 136, 201, 191),
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
                  MaterialPageRoute(builder: (context) => const SignUpScreen()),
                ),
                child: const SizedBox(
                  width: 232.0,
                  height: 40.0,
                  child: Center(
                    child: Text(
                      "FAZER CADASTRO",
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
          const SizedBox(height: 44),
          const Text(
            '''Já possui cadastro?''',
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 117, 117, 117),
            ),
          ),
          const SizedBox(height: 16),
          //login
          Container(
            alignment: Alignment.center,
            width: 232.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 136, 201, 191),
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
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                ),
                child: const SizedBox(
                  width: 232.0,
                  height: 40.0,
                  child: Center(
                    child: Text(
                      "FAZER LOGIN",
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
        ],
      ),
    );
  }
}
