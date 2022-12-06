import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AnimalRegistryScreen extends StatelessWidget {
  const AnimalRegistryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro do Animal'),
      ),
      body: const AnimalForm()
    );
  }
}

class AnimalForm extends StatefulWidget {
  const AnimalForm({super.key});

  @override
  CompleteForm createState() {
    return CompleteForm();
  }
}

class CompleteForm extends State {
  FirebaseFirestore db = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  hintText: "Nome do animal",
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
                onPressed: () => animalRegistry(),
                child: const Text("PROCURAR AJUDA"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void animalRegistry() {
    String id = const Uuid().v1();

    db.collection('animals').doc(id).set({
      'name': _nameController.text,
    });

    const snackBar = SnackBar(
      content: Text('Cadastro Realizado!'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}