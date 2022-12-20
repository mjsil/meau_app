import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user/index.dart';
import '../../services/auth/index.dart';

class MyAnimalsScreen extends StatelessWidget {
  const MyAnimalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<User?> snapshot) {
        final User? user = snapshot.data;
        final Stream<QuerySnapshot> animals = FirebaseFirestore.instance
          .collection('animal')
          .where("owner", isEqualTo: user?.uid)
          .snapshots();
        
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
    );
  }
}