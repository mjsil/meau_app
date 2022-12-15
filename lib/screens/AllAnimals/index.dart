import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AnimalsScreen extends StatelessWidget {
  const AnimalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adotar Animal'),
      ),
      body: const AnimalsView());
  }
}

class AnimalsView extends StatefulWidget {
  const AnimalsView({super.key});

  @override
  CompleteAnimals createState() {
    return CompleteAnimals();
  }
}

class CompleteAnimals extends State {
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
    Stream<QuerySnapshot> productRef = db.collection("animal").snapshots();

    productRef.forEach((field) {
      field.docs.asMap().forEach((index, data) {
        animals.add(field.docs[index]["name"]);
      });
    });

    return animals;
  }
}
