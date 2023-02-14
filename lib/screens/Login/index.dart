import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meau_app/services/auth/index.dart';
import 'package:provider/provider.dart';

import '../SideBarMenu/index.dart';
import '../SignUp/index.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(
            color: Color.fromARGB(255, 67, 67, 67),
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(255, 136, 201, 191)),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 67, 67, 67)),
        backgroundColor: const Color.fromARGB(255, 207, 233, 233),
        elevation: 0,
      ),
      drawer: const NavBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 64),
            //User Name
            SizedBox(
              width: 312,
              child: TextField(
                cursorColor: const Color.fromARGB(255, 136, 201, 191),
                style: const TextStyle(
                  color: Color.fromARGB(255, 189, 189, 189),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
                controller: emailController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 8,
                  ),
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 230, 231, 232),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.8,
                          color: Color.fromARGB(255, 230, 231, 232))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 136, 201, 191))),
                  hintText: "Email",
                ),
              ),
            ),
            const SizedBox(height: 20),
            //Password
            SizedBox(
              width: 312,
              child: TextField(
                cursorColor: const Color.fromARGB(255, 136, 201, 191),
                obscureText: true,
                style: const TextStyle(
                  color: Color.fromARGB(255, 189, 189, 189),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
                controller: passwordController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 8,
                  ),
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 230, 231, 232),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.8,
                          color: Color.fromARGB(255, 230, 231, 232))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 136, 201, 191))),
                  hintText: "Senha",
                ),
              ),
            ),
            const SizedBox(height: 48),
            //enter
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
                  onTap: () async {
                    try {
                      await authService.signInWithEmailAndPassword(
                        emailController.text,
                        passwordController.text,
                      );

                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushNamed("/home");
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Usuário não encontrado'),
                      ));
                    }
                  },
                  child: const SizedBox(
                    width: 232.0,
                    height: 40.0,
                    child: Center(
                      child: Text(
                        "ENTRAR",
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
            const SizedBox(height: 8),
            Container(
              alignment: Alignment.center,
              width: 232.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 207, 233, 233),
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
                        builder: (context) => const SignUpScreen()),
                  ),
                  child: const SizedBox(
                    width: 232.0,
                    height: 40.0,
                    child: Center(
                      child: Text(
                        "CADASTRAR",
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
      ),
    );
  }
}
