import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../MyAnimalDetail/index.dart';
import '../../services/storage/index.dart';

class MyAnimalsScreen extends StatefulWidget {
  const MyAnimalsScreen({Key? key}) : super(key: key);

  @override
  State<MyAnimalsScreen> createState() => _MyAnimalsScreenState();
}

class _MyAnimalsScreenState extends State<MyAnimalsScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final Storage storage = Storage();

    const Color background = Color.fromARGB(255, 207, 233, 229);
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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      appBar: AppBar(
        title: const Text(
          "Meus Pets",
          style: TextStyle(
            color: Color.fromARGB(255, 67, 67, 67),
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(255, 88, 155, 155)),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 67, 67, 67)),
        backgroundColor: const Color.fromARGB(255, 136, 201, 191),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("animal")
                  .where("owner", isEqualTo: user?.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  final snap = snapshot.data!.docs;
                  return ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: snap.length,
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
                              child: Column(
                                children: [
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      const SizedBox(width: 10),
                                      Text(
                                        snap[index]['name'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(255, 67, 67, 67),
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const Spacer(),
                                      const Icon(Icons.error),
                                      const SizedBox(width: 10),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  FutureBuilder(
                                      future: storage
                                          .downloadURL(snap[index]['photo']),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<String> snapshot) {
                                        if (snapshot.connectionState ==
                                                ConnectionState.done &&
                                            snapshot.hasData) {
                                          return Container(
                                            width: 344,
                                            height: 183,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        snapshot.data!),
                                                    fit: BoxFit.cover)),
                                            child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => MyAnimalDetailScreen(
                                                          name: snap[index]
                                                              ['name'],
                                                          pictureUrl:
                                                              snapshot.data!,
                                                          sex: snap[index]
                                                              ['sex'],
                                                          size: snap[index]
                                                              ['size'],
                                                          age: snap[index]
                                                              ['age'],
                                                          castrated: snap[index]
                                                              ['castrated'],
                                                          dewormed: snap[index]
                                                              ['dewormed'],
                                                          vaccinated: snap[index]
                                                              ['vaccinated'],
                                                          sick: snap[index]
                                                              ['sick'],
                                                          sickness: snap[index]
                                                              ['sickness'],
                                                          history: snap[index]
                                                              ['history'],
                                                          playful: snap[index]
                                                              ['playful'],
                                                          shy: snap[index]
                                                              ['shy'],
                                                          calm: snap[index]
                                                              ['calm'],
                                                          watchDog: snap[index]
                                                              ['watchDog'],
                                                          lovable: snap[index]['lovable'],
                                                          lazy: snap[index]['lazy'],
                                                          adoptionTerm: snap[index]['adoptionTerm'],
                                                          housePicture: snap[index]['housePicture'],
                                                          previousVisit: snap[index]['previousVisit'],
                                                          id: snap[index]["id"])),
                                                ),
                                              ),
                                            ),
                                          );
                                        }

                                        return const SizedBox(
                                            width: 344,
                                            height: 183,
                                            child: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ));
                                      }),
                                  const SizedBox(height: 5),
                                  const Center(
                                    child: Text(
                                      "3 NOVOS INTERESSADOS",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color.fromARGB(255, 67, 67, 67),
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Center(
                                    child: Text(
                                      "APADRINHAMENTO | AJUDA",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color.fromARGB(255, 67, 67, 67),
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
