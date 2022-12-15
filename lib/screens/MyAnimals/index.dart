import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyAnimalsScreen extends StatelessWidget {
  const MyAnimalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Animais'),
      ),
      body: const MyAnimalsView());
  }
}

class MyAnimalsView extends StatefulWidget {
  const MyAnimalsView({super.key});

  @override
  CompleteMyAnimals createState() {
    return CompleteMyAnimals();
  }
}

class CompleteMyAnimals extends State {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<String>?>(
        future: getAnimals(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Text(snapshot.data?[index] ?? "got null");
              },
            );
          }

          else {
            return const Text("CARREGANDO...");
          }
        },
      ) 
    );
  }

  Future<List<String>> getAnimals() async {
    List<String> animals= [];
    Stream<QuerySnapshot> productRef = db.collection("animal").where("owner", isEqualTo: "pedro@gmail.com").snapshots();

    productRef.forEach((field) {
      field.docs.asMap().forEach((index, data) {
        animals.add(field.docs[index]["name"]);
      });
    });

    return animals;
  }
}
