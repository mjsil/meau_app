import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../models/user/index.dart';
import '../../services/auth/index.dart';
import '../SideBarMenu/index.dart';

class MyAnimalsScreen extends StatelessWidget {
  const MyAnimalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    const Color background = Color.fromARGB(255, 254, 226, 155);
    const Color fill = Colors.white;
    final List<Color> gradient = [
      background,
      background,
      fill,
      fill,
    ];
    const double fillPercent = 50;
    const double fillStop = (100 - fillPercent) / 100;
    final List<double> stops = [0.0, fillStop, fillStop, 1.0];

    return StreamBuilder<User?>(
        stream: authService.user,
        builder: (_, AsyncSnapshot<User?> snapshot) {
          final User? user = snapshot.data;
          final Stream<QuerySnapshot> animals = FirebaseFirestore.instance
              .collection('animal')
              .where("owner", isEqualTo: user?.uid)
              .snapshots();

          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 250, 250, 250),
            appBar: AppBar(
              title: const Text(
                "Adotar",
                style: TextStyle(
                  color: Color.fromARGB(255, 67, 67, 67),
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // do something
                  },
                )
              ],
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Color.fromARGB(255, 136, 201, 191)),
              iconTheme:
                  const IconThemeData(color: Color.fromARGB(255, 67, 67, 67)),
              backgroundColor: const Color.fromARGB(255, 255, 211, 88),
              elevation: 0,
            ),
            drawer: const NavBar(),
            body: Container(
              padding: const EdgeInsets.all(16),
              child: ListView(children: <Widget>[
                SizedBox(
                  height: 300,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: animals,
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot,
                    ) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                            return Center(
                              child: Column(
                                children: [
                                  //enter
                                  const SizedBox(height: 20),
                                  Container(
                                    width: 344,
                                    height: 264,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: gradient,
                                        stops: stops,
                                        end: Alignment.bottomCenter,
                                        begin: Alignment.topCenter,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: -1,
                                          blurRadius: 1,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    alignment: Alignment.topLeft,
                                    child: ListView(
                                      children: [
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            const SizedBox(width: 10),
                                            Text(data.docs[index]['name']),
                                            const Spacer(),
                                            const Icon(Icons.favorite_border),
                                            const SizedBox(width: 10),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          width: 344,
                                          height: 183,
                                          decoration: const BoxDecoration(
                                              image: DecorationImage(
                                            image: AssetImage(
                                                'assets/ImagemTeste/pet.jpeg'),
                                            fit: BoxFit.cover,
                                          )),
                                        ),
                                        const SizedBox(height: 5),
                                        Wrap(
                                          alignment: WrapAlignment.spaceAround,
                                          children: const [
                                            Text("MACHO"),
                                            Text("ADULTO"),
                                            Text("MÉDIO"),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        const Center(
                                            child: Text(
                                                "SAMAMBAIA SUL – DISTRITO FEDERAL"))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                  ),
                ),
              ]),
            ),
          );
        });
  }
}
