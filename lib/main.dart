import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Cadastro';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  SignUpScreen createState() {
    return SignUpScreen();
  }
}

class SignUpScreen extends State {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
                backgroundColor: Colors.black,
                textStyle: const TextStyle(
                  fontSize: 12,
                ),
              ),
              onPressed: () => SigUp(),
              child: const Text("CADASTRAR"),
            ),
          ),
        ],
      ),
    );
  }

  void SigUp() async {
    try {
      final response =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (response != null) {
        const snackBar = SnackBar(
          content: Text('Success!'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (error) {
      const snackBar = SnackBar(
        content: Text('Error!'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
