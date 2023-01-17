import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InterestedMyAnimalScreen extends StatefulWidget {
  final String id;
  const InterestedMyAnimalScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<InterestedMyAnimalScreen> createState() =>
      _InterestedMyAnimalScreenState();
}

class _InterestedMyAnimalScreenState extends State<InterestedMyAnimalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      appBar: AppBar(
        title: const Text(
          "Interessados",
          style: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 67, 67, 67),
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Color.fromARGB(255, 67, 67, 67),
            ),
            onPressed: () {
              // do something
            },
          )
        ],
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(255, 136, 201, 191)),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 67, 67, 67)),
        backgroundColor: const Color.fromARGB(255, 207, 233, 229),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("interested")
                  .where("animalId", isEqualTo: widget.id)
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
                            Container(
                              alignment: Alignment.center,
                              width: 200.0,
                              height: 200.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/ImagemTeste/ImagemDePerfil.jpeg'),
                                ),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(25.0),
                                          ),
                                        ),
                                        builder: (context) {
                                          return SizedBox(
                                            height: 100,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Material(
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                    onTap: () {
                                                      // print(
                                                      //   FirebaseFirestore
                                                      //       .instance
                                                      //       .collection(
                                                      //           "animal")
                                                      //       .doc(snap[index]
                                                      //           ['animalId'])
                                                      //       .update({
                                                      //         "owner":
                                                      //             "teste do owner"
                                                      //       })
                                                      //       .then((_) => print(
                                                      //           'Success'))
                                                      //       .catchError(
                                                      //         (error) => print(
                                                      //             'Failed: $error'),
                                                      //       ),
                                                      // );
                                                    },
                                                    child: const SizedBox(
                                                      width: double.infinity,
                                                      height: 50,
                                                      child: Center(
                                                        child: Text(
                                                          "ACEITAR ADOÇÃO",
                                                          style: TextStyle(
                                                            fontSize: 12.0,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Color.fromARGB(
                                                              255,
                                                              67,
                                                              67,
                                                              67,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Material(
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                    onTap: () {
                                                      //print(snapshot.data!.docs[index].id);
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              "interested")
                                                          .doc(snapshot.data!
                                                              .docs[index].id)
                                                          .delete();
                                                    },
                                                    child: const SizedBox(
                                                      width: double.infinity,
                                                      height: 50,
                                                      child: Center(
                                                        child: Text(
                                                          "NEGAR ADOÇÃO",
                                                          style: TextStyle(
                                                            fontSize: 12.0,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              snap[index]['interestedName'],
                              style: const TextStyle(
                                fontSize: 15,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 67, 67, 67),
                              ),
                            ),
                            Text(
                              "${snap[index]['interestedAge']} anos",
                              style: const TextStyle(
                                fontSize: 15,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 67, 67, 67),
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            Center(
              child: Container(
                width: 232.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 136, 201, 191),
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      print("tapped");
                    },
                    child: const SizedBox(
                      width: 232.0,
                      height: 40.0,
                      child: Center(
                        child: Text(
                          "IR PARA O CHAT",
                          style: TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 67, 67, 67),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//snap[index]['interestedName'],
//"${snap[index]['interestedAge']} anos",
