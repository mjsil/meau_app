import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AnimalsScreen extends StatelessWidget {
  final Stream<QuerySnapshot> animals = FirebaseFirestore.instance
    .collection('animal')
    .snapshots();

  AnimalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adotar'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 300,
              child: StreamBuilder<QuerySnapshot>(
                stream: animals,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot,  
                ) {
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return const Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  final data = snapshot.requireData;

                  return ListView.builder(
                    itemCount: data.size,
                    itemBuilder: (context, index) {
                      return Text(data.docs[index]['name']);
                    }
                  );
                },
              ),
            ),
          ]
        ),
      ),
    );
  }
}