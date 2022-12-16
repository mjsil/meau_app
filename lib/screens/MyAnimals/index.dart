import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyAnimalsScreen extends StatelessWidget {
  const MyAnimalsScreen({super.key, required this.user});
  final String user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Animais'),
      ),
      body: MyAnimalsView(user: user));
  }
}

class MyAnimalsView extends StatefulWidget {
  final String user;

  const MyAnimalsView({ Key? key, required this.user }): super(key: key);

  @override
  CompleteMyAnimals createState() {
    return CompleteMyAnimals();
  }
}

class CompleteMyAnimals extends State<MyAnimalsView> {
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
            return Text('>>>> ${widget.user}');
          }
        },
      ) 
    );
  }

  Future<List<String>> getAnimals() async {
    List<String> animals= [];
    Stream<QuerySnapshot> productRef = db.collection("animal").where("owner", isEqualTo: widget.user).snapshots();

    productRef.forEach((field) {
      field.docs.asMap().forEach((index, data) {
        animals.add(field.docs[index]["name"]);
      });
    });

    return animals;
  }
}
