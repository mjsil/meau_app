import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro Pessoal'),
        ),
        body: const SignUpForm());
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  CompleteForm createState() {
    return CompleteForm();
  }
}

class CompleteForm extends State {
  FirebaseFirestore db = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20),
            const Text("INFORMAÇÕES PESSOAIS"),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  hintText: "Nome completo",
                  contentPadding: EdgeInsets.all(8),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  )),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: "Idade",
                  contentPadding: EdgeInsets.all(8),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  )),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  hintText: "E-mail",
                  contentPadding: EdgeInsets.all(8),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  )),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _stateController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  hintText: "Estado",
                  contentPadding: EdgeInsets.all(8),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  )),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _cityController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  hintText: "Cidade",
                  contentPadding: EdgeInsets.all(8),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  )),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _addressController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  hintText: "Endereço",
                  contentPadding: EdgeInsets.all(8),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  )),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: "Telefone",
                  contentPadding: EdgeInsets.all(8),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  )),
            ),
            const SizedBox(height: 20),
            const Text("INFORMAÇÕES DE PERFIL"),
            const SizedBox(height: 20),
            TextFormField(
              controller: _usernameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  hintText: "Nome de usuário",
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
            const SizedBox(height: 20),
            TextFormField(
              controller: _confirmPasswordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: const InputDecoration(
                  hintText: "Confirmar senha",
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
                onPressed: () => signUp(),
                child: const Text("FAZER CADASTRO"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signUp() {
    String id = const Uuid().v1();

    db.collection('people').doc(id).set({
      'name': _nameController.text,
      'age': _ageController.text,
      'email': _emailController.text,
      'state': _stateController.text,
      'city': _cityController.text,
      'address': _addressController.text,
      'phone': _phoneController.text,
      'username': _usernameController.text,
      'password': _passwordController.text,
      'confirmPassword': _confirmPasswordController.text,
    });

    const snackBar = SnackBar(
      content: Text('Cadastro Realizado!'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
