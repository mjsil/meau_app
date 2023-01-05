import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:core';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class AnimalDetailScreen extends StatelessWidget {
  final String name;
  final String pictureUrl;
  final String sex;
  final String size;
  final String age;
  final bool castrated;
  final bool dewormed;
  final bool vaccinated;
  final bool sick;
  //temper
  final bool playful;
  final bool shy;
  final bool calm;
  final bool watchDog;
  final bool lovable;
  final bool lazy;
  //adoption requirement
  final bool adoptionTerm;
  final bool housePicture;
  final bool previousVisit;
  //
  final String sickness;
  final String history;

  const AnimalDetailScreen({
    Key? key,
    required this.name,
    required this.pictureUrl,
    required this.sex,
    required this.size,
    required this.age,
    required this.castrated,
    required this.vaccinated,
    required this.dewormed,
    required this.sick,
    required this.sickness,
    required this.history,
    //temper
    required this.playful,
    required this.shy,
    required this.calm,
    required this.watchDog,
    required this.lovable,
    required this.lazy,
    //adoption requirement
    required this.adoptionTerm,
    required this.housePicture,
    required this.previousVisit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> temperText = [
      (playful ? "brincalhão" : ""),
      (shy ? "tímido" : ""),
      (calm ? "calmo" : ""),
      (watchDog ? "guarda" : ""),
      (lovable ? "amoroso" : ""),
      (lazy ? "preguiçoso" : ""),
    ];

    List<String> adoptRequirementText = [
      (adoptionTerm ? "termo de adoção" : ""),
      (housePicture ? "fotos da casa" : ""),
      (previousVisit ? "visita prévia" : ""),
    ];

    temperText.removeWhere((item) => item == "");
    adoptRequirementText.removeWhere((item) => item == "");

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      appBar: AppBar(
        title: Text(
          name,
          style: const TextStyle(
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
      body: ListView(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  Container(
                    height: 184,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(pictureUrl), fit: BoxFit.cover),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: -1,
                          blurRadius: 1,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 20,
                top: 157,
                child: FloatingActionButton(
                  backgroundColor: const Color.fromARGB(255, 250, 250, 250),
                  onPressed: () {},
                  child: const Icon(
                    Icons.favorite_border,
                    color: Color.fromARGB(255, 67, 67, 67),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 67, 67, 67),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "SEXO",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 247, 168, 0),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          sex.capitalize(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 117, 117, 117),
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "PORTE",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 247, 168, 0),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          size.capitalize(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 117, 117, 117),
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "IDADE",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 247, 168, 0),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          age.capitalize(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 117, 117, 117),
                          ),
                        )
                      ],
                    ),
                    const Spacer(flex: 3),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "LOCALIZAÇÃO",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 247, 168, 0),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Samambaia Sul – Distrito Federal",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 117, 117, 117),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "CASTRADO",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 247, 168, 0),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          castrated ? "Sim" : "Não",
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 117, 117, 117),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "VACINADO",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 247, 168, 0),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          vaccinated ? "Sim" : "Não",
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 117, 117, 117),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "VERMIFUGADO",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 247, 168, 0),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          dewormed ? "Sim" : "Não",
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 117, 117, 117),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "DOENÇAS",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 247, 168, 0),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          sick ? "Doente" : "Nenhuma",
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 117, 117, 117),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(height: 1, thickness: 0.3),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "TEMPERAMENTO",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 247, 168, 0),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      temperText.join(', ').capitalize(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 117, 117, 117),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(height: 1, thickness: 0.3),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "EXIGÊNCIAS DO DOADOR",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 247, 168, 0),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      adoptRequirementText.join(', ').capitalize(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 117, 117, 117),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(height: 1, thickness: 0.3),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "MAIS SOBRE ${name.toUpperCase()}",
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 247, 168, 0),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      history,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 117, 117, 117),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    width: 232.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 211, 88),
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
                        onTap: () => {},
                        child: const SizedBox(
                          width: 232.0,
                          height: 40.0,
                          child: Center(
                            child: Text(
                              "PRETENDO ADOTAR",
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
          )
        ],
      ),
    );
  }
}
