//não usado
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meau_app/screens/SideBarMenu/index.dart';

import '../Home/index.dart';
import '../SignUp/index.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SignInForm());
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  CompleteForm createState() {
    return CompleteForm();
  }
}

class CompleteForm extends State {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(255, 136, 201, 191)),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 67, 67, 67)),
        title: const Text(
          'Login',
          style: TextStyle(color: Color.fromARGB(255, 67, 67, 67)),
        ),
        backgroundColor: const Color.fromARGB(255, 207, 233, 229),
      ),
      drawer: const NavBar(),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    hintText: "Email",
                    contentPadding: EdgeInsets.all(8),
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    )),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: const InputDecoration(
                    hintText: "Senha",
                    contentPadding: EdgeInsets.all(8),
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    )),
              ),
              const SizedBox(height: 52),
              SizedBox(
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
                  onPressed: () => sigIn(),
                  child: const Text("ENTRAR"),
                ),
              ),
              const SizedBox(height: 52),
              SizedBox(
                width: 232,
                height: 40,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.black,
                    textStyle: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpScreen()),
                  ),
                  child: const Text("CADASTRAR"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigationHomeScreen(email) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(email: ('$email'))),
    );
  }

  void sigIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      navigationHomeScreen(_emailController.text);
    } catch (error) {
      const snackBar = SnackBar(
        content: Text('Error!'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
