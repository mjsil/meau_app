import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../services/storage/index.dart';
import '../AnimalDetail/index.dart';

class AdoptAnimal extends StatefulWidget {
  const AdoptAnimal({Key? key}) : super(key: key);

  @override
  State<AdoptAnimal> createState() => _AdoptAnimalState();
}

class _AdoptAnimalState extends State<AdoptAnimal> {
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();

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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      appBar: AppBar(
        title: const Text(
          "Adotar",
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
            statusBarColor: Color.fromARGB(255, 247, 168, 0)),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 67, 67, 67)),
        backgroundColor: const Color.fromARGB(255, 255, 211, 88),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("animal").snapshots(),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                      const Icon(Icons.favorite_border),
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
                                          final String snapPictureUrl =
                                              snapshot.data!;

                                          final String snapName =
                                              snap[index]['name'];

                                          String snapOwner =
                                              snap[index]['owner'];

                                          String snapSex = snap[index]['sex'];

                                          String snapSize = snap[index]['size'];

                                          String snapAge = snap[index]['age'];

                                          String snapSickness =
                                              snap[index]['sickness'];

                                          String snapHistory =
                                              snap[index]['history'];

                                          bool snapCastrated =
                                              snap[index]['castrated'];

                                          bool snapDewormed =
                                              snap[index]['dewormed'];

                                          bool snapVaccinated =
                                              snap[index]['vaccinated'];

                                          bool snapSick = snap[index]['sick'];

                                          bool snapPlayful =
                                              snap[index]['playful'];

                                          bool snapShy = snap[index]['shy'];

                                          bool snapCalm = snap[index]['calm'];

                                          bool snapWatchDog =
                                              snap[index]['watchDog'];

                                          bool snapLovable =
                                              snap[index]['lovable'];

                                          bool snapLazy = snap[index]['lazy'];

                                          bool snapAdoptionTerm =
                                              snap[index]['adoptionTerm'];

                                          bool snapHousePicture =
                                              snap[index]['housePicture'];

                                          bool snapPreviousVisit =
                                              snap[index]['previousVisit'];

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
                                                      builder: (context) =>
                                                          AnimalDetailScreen(
                                                            name: snapName,
                                                            pictureUrl:
                                                                snapPictureUrl,
                                                            sex: snapSex,
                                                            size: snapSize,
                                                            age: snapAge,
                                                            castrated:
                                                                snapCastrated,
                                                            dewormed:
                                                                snapDewormed,
                                                            vaccinated:
                                                                snapVaccinated,
                                                            sick: snapSick,
                                                            sickness:
                                                                snapSickness,
                                                            history:
                                                                snapHistory,
                                                            playful:
                                                                snapPlayful,
                                                            shy: snapShy,
                                                            calm: snapCalm,
                                                            watchDog:
                                                                snapWatchDog,
                                                            lovable:
                                                                snapLovable,
                                                            lazy: snapLazy,
                                                            adoptionTerm:
                                                                snapAdoptionTerm,
                                                            housePicture:
                                                                snapHousePicture,
                                                            previousVisit:
                                                                snapPreviousVisit,
                                                            owner: snapOwner,
                                                          )),
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
                                  Row(
                                    children: [
                                      const Spacer(),
                                      Text(
                                        snap[index]['sex'],
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color:
                                              Color.fromARGB(255, 67, 67, 67),
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        snap[index]['age'],
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color:
                                              Color.fromARGB(255, 67, 67, 67),
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        snap[index]['size'],
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color:
                                              Color.fromARGB(255, 67, 67, 67),
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  const Center(
                                    child: Text(
                                      "SAMAMBAIA SUL – DISTRITO FEDERAL",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color.fromARGB(255, 67, 67, 67),
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
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
