import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../services/storage/index.dart';

class AnimalRegistryScreen extends StatefulWidget {
  const AnimalRegistryScreen({super.key});

  @override
  AnimalRegistry createState() {
    return AnimalRegistry();
  }
}

class AnimalRegistry extends State<AnimalRegistryScreen> {
  //Instancia Firestore
  FirebaseFirestore db = FirebaseFirestore.instance;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController sicknessController = TextEditingController();
  final TextEditingController historyController = TextEditingController();

  String? species;
  String? sex;
  String? size;
  String? age;

  //temper
  bool? playful = false;
  bool? shy = false;
  bool? calm = false;
  bool? watchDog = false;
  bool? lovable = false;
  bool? lazy = false;

  //helth
  bool? vaccinated = false;
  bool? dewormed = false;
  bool? castrated = false;
  bool? sick = false;

  //adoption requirement
  bool? adoptionTerm = false;
  bool? housePicture = false;
  bool? previousVisit = false;

  late String imageName = '';
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    var uuid = const Uuid();
    final uid = uuid.v4();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      appBar: AppBar(
        title: const Text(
          "Cadastro do Animal",
          style: TextStyle(
            color: Color.fromARGB(255, 67, 67, 67),
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(255, 247, 168, 0)),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 67, 67, 67)),
        backgroundColor: const Color.fromARGB(255, 255, 211, 88),
        elevation: 0,
      ),
      body: ListView(
          padding: const EdgeInsetsDirectional.only(start: 24, end: 24),
          children: [
            const SizedBox(height: 15),
            Row(
              children: const [
                Text(
                  "Tenho interesse em cadastrar o animal para:",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 67, 67, 67),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            //BOTÃO ADOÇÃO
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Wrap(
                  spacing: 8,
                  children: [
                    //ADOÇÃO
                    Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 211, 88),
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: -1,
                            blurRadius: 1,
                            offset: const Offset(0, 3),
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
                            width: 100,
                            height: 40,
                            child: Center(
                              child: Text(
                                "ADOÇÃO",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 67, 67, 67),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    //APADRINHAR
                    Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 241, 242, 242),
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: -1,
                            blurRadius: 1,
                            offset: const Offset(0, 3),
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
                            width: 100,
                            height: 40,
                            child: Center(
                              child: Text(
                                "APADRINHAR",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 67, 67, 67),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    //AJUDA
                    Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 241, 242, 242),
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: -1,
                            blurRadius: 1,
                            offset: const Offset(0, 3),
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
                            width: 100,
                            height: 40,
                            child: Center(
                              child: Text(
                                "AJUDA",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 67, 67, 67),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(height: 1, thickness: 0.3),
            const SizedBox(height: 16),
            const Text(
              "Adoção",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 67, 67, 67),
              ),
            ),
            //NOME DO ANIMAL
            const SizedBox(height: 20),
            const Text(
              "NOME DO ANIMAL",
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 247, 168, 0),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 312,
              child: TextFormField(
                controller: nameController,
                cursorWidth: 1,
                cursorColor: const Color.fromARGB(255, 247, 168, 0),
                style: const TextStyle(
                  color: Color.fromARGB(255, 189, 189, 189),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 8,
                  ),
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 230, 231, 232),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 230, 231, 232),
                  )),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 247, 168, 0))),
                  hintText: "Nome do animal",
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "FOTOS DO ANIMAL",
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 247, 168, 0),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 312,
                  height: 128,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 241, 242, 242),
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: -1,
                        blurRadius: 1,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () async {
                        final image = await ImagePicker().pickImage(source: ImageSource.gallery);

                        if(image == null) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Imagem não selecionada!'),
                          ));

                          return;
                        }

                        final path = image.path;

                        storage.uploadFile(path, uid).then((value) => 
                          setState(() {
                            imageName = uid;
                        }));
                      },
                      child: SizedBox(
                        width: 312,
                        height: 128,
                        child: Center(
                          child: imageName == ''
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  SizedBox(height: 44),
                                  Icon(Icons.control_point),
                                  Text(
                                    "adicionar fotos",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 67, 67, 67),
                                    ),
                                  ),
                                  SizedBox(height: 44),
                                ],
                              )
                            : FutureBuilder(
                                future: storage.downloadURL(imageName),
                                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                  if(snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                                    return SizedBox(
                                      height: 300,
                                      child: Image.network(
                                        snapshot.data!, 
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  }
                                  
                                  return const CircularProgressIndicator();
                                }
                              ),
                        )
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //ESPÉCIE
            const SizedBox(height: 20),
            const Text(
              "ESPÉCIE",
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 247, 168, 0),
              ),
            ),
            const SizedBox(height: 16),
            Theme(
              data: ThemeData(
                primarySwatch: Colors.amber,
                unselectedWidgetColor: const Color.fromARGB(255, 117, 117, 117),
              ),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: "Cachorro",
                        groupValue: species,
                        onChanged: (value) {
                          setState(() {
                            species = value.toString();
                          });
                        },
                      ),
                      const Text(
                        "Cachorro",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 117, 117, 117),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    left: 124,
                    child: Row(
                      children: [
                        Radio(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: "Gato",
                          groupValue: species,
                          onChanged: (value) {
                            setState(() {
                              species = value.toString();
                            });
                          },
                        ),
                        const Text(
                          "Gato",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 117, 117, 117),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            //SEXO
            const SizedBox(height: 20),
            const Text(
              "SEXO",
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 247, 168, 0),
              ),
            ),
            const SizedBox(height: 16),
            Theme(
              data: ThemeData(
                primarySwatch: Colors.amber,
                unselectedWidgetColor: const Color.fromARGB(255, 117, 117, 117),
              ),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: "MACHO",
                        groupValue: sex,
                        onChanged: (value) {
                          setState(() {
                            sex = value.toString();
                          });
                        },
                      ),
                      const Text(
                        "Macho",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 117, 117, 117),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    left: 124,
                    child: Row(
                      children: [
                        Radio(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: "FÊMEA",
                          groupValue: sex,
                          onChanged: (value) {
                            setState(() {
                              sex = value.toString();
                            });
                          },
                        ),
                        const Text(
                          "Fêmea",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 117, 117, 117),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            //PORTE
            const SizedBox(height: 20),
            const Text(
              "PORTE",
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 247, 168, 0),
              ),
            ),
            const SizedBox(height: 16),
            Theme(
              data: ThemeData(
                primarySwatch: Colors.amber,
                unselectedWidgetColor: const Color.fromARGB(255, 117, 117, 117),
              ),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: "PEQUENO",
                        groupValue: size,
                        onChanged: (value) {
                          setState(() {
                            size = value.toString();
                          });
                        },
                      ),
                      const Text(
                        "Pequeno",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 117, 117, 117),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    left: 124,
                    child: Row(
                      children: [
                        Radio(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: "MÉDIO",
                          groupValue: size,
                          onChanged: (value) {
                            setState(() {
                              size = value.toString();
                            });
                          },
                        ),
                        const Text(
                          "Médio",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 117, 117, 117),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    left: 220,
                    child: Row(
                      children: [
                        Radio(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: "GRANDE",
                          groupValue: size,
                          onChanged: (value) {
                            setState(() {
                              size = value.toString();
                            });
                          },
                        ),
                        const Text(
                          "Grande",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 117, 117, 117),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            //IDADE
            const SizedBox(height: 20),
            const Text(
              "IDADE",
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 247, 168, 0),
              ),
            ),
            const SizedBox(height: 16),
            Theme(
              data: ThemeData(
                primarySwatch: Colors.amber,
                unselectedWidgetColor: const Color.fromARGB(255, 117, 117, 117),
              ),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: "FILHOTE",
                        groupValue: age,
                        onChanged: (value) {
                          setState(() {
                            age = value.toString();
                          });
                        },
                      ),
                      const Text(
                        "Filhote",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 117, 117, 117),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    left: 124,
                    child: Row(
                      children: [
                        Radio(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: "ADULTO",
                          groupValue: age,
                          onChanged: (value) {
                            setState(() {
                              age = value.toString();
                            });
                          },
                        ),
                        const Text(
                          "Adulto",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 117, 117, 117),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    left: 220,
                    child: Row(
                      children: [
                        Radio(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: "IDOSO",
                          groupValue: age,
                          onChanged: (value) {
                            setState(() {
                              age = value.toString();
                            });
                          },
                        ),
                        const Text(
                          "Idoso",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 117, 117, 117),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "TEMPERAMENTO",
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 247, 168, 0),
              ),
            ),
            const SizedBox(height: 16),
            Theme(
              data: ThemeData(
                primarySwatch: Colors.amber,
                unselectedWidgetColor: const Color.fromARGB(255, 117, 117, 117),
              ),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: playful,
                        onChanged: (bool? value) {
                          setState(() {
                            playful = value;
                          });
                        },
                      ),
                      const Text(
                        "Brincalhão",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 117, 117, 117),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    left: 124,
                    child: Row(
                      children: [
                        Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: shy,
                          onChanged: (bool? value) {
                            setState(() {
                              shy = value;
                            });
                          },
                        ),
                        const Text(
                          "Tímido",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 117, 117, 117),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    left: 220,
                    child: Row(
                      children: [
                        Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: calm,
                          onChanged: (bool? value) {
                            setState(() {
                              calm = value;
                            });
                          },
                        ),
                        const Text(
                          "Calmo",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 117, 117, 117),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 28),
            Theme(
              data: ThemeData(
                primarySwatch: Colors.amber,
                unselectedWidgetColor: const Color.fromARGB(255, 117, 117, 117),
              ),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: watchDog,
                        onChanged: (bool? value) {
                          setState(() {
                            watchDog = value;
                          });
                        },
                      ),
                      const Text(
                        "Guarda",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 117, 117, 117),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    left: 124,
                    child: Row(
                      children: [
                        Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: lovable,
                          onChanged: (bool? value) {
                            setState(() {
                              lovable = value;
                            });
                          },
                        ),
                        const Text(
                          "Amoroso",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 117, 117, 117),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    left: 220,
                    child: Row(
                      children: [
                        Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: lazy,
                          onChanged: (bool? value) {
                            setState(() {
                              lazy = value;
                            });
                          },
                        ),
                        const Text(
                          "Preguiçoso",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 117, 117, 117),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            //aqui------------------------------------------------------------INICIO
            const SizedBox(height: 20),
            const Text(
              "SAÚDE",
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 247, 168, 0),
              ),
            ),
            const SizedBox(height: 16),
            Theme(
              data: ThemeData(
                primarySwatch: Colors.amber,
                unselectedWidgetColor: const Color.fromARGB(255, 117, 117, 117),
              ),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: vaccinated,
                        onChanged: (bool? value) {
                          setState(() {
                            vaccinated = value;
                          });
                        },
                      ),
                      const Text(
                        "Vacinado",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 117, 117, 117),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    left: 124,
                    child: Row(
                      children: [
                        Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: dewormed,
                          onChanged: (bool? value) {
                            setState(() {
                              dewormed = value;
                            });
                          },
                        ),
                        const Text(
                          "Vermifugado",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 117, 117, 117),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Theme(
              data: ThemeData(
                primarySwatch: Colors.amber,
                unselectedWidgetColor: const Color.fromARGB(255, 117, 117, 117),
              ),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: castrated,
                        onChanged: (bool? value) {
                          setState(() {
                            castrated = value;
                          });
                        },
                      ),
                      const Text(
                        "Castrado",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 117, 117, 117),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    left: 124,
                    child: Row(
                      children: [
                        Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: sick,
                          onChanged: (bool? value) {
                            setState(() {
                              sick = value;
                            });
                          },
                        ),
                        const Text(
                          "Doente",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 117, 117, 117),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 312,
              child: TextFormField(
                controller: sicknessController,
                cursorWidth: 1,
                cursorColor: const Color.fromARGB(255, 247, 168, 0),
                style: const TextStyle(
                  color: Color.fromARGB(255, 189, 189, 189),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 8,
                  ),
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 230, 231, 232),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 230, 231, 232),
                  )),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 247, 168, 0))),
                  hintText: "Doenças do animal",
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "EXIGÊNCIAS PARA ADOÇÃO",
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 247, 168, 0),
              ),
            ),
            const SizedBox(height: 16),
            Theme(
              data: ThemeData(
                primarySwatch: Colors.amber,
                unselectedWidgetColor: const Color.fromARGB(255, 117, 117, 117),
              ),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: adoptionTerm,
                        onChanged: (bool? value) {
                          setState(() {
                            adoptionTerm = value;
                          });
                        },
                      ),
                      const Text(
                        "Termo de adoção",
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
            ),
            const SizedBox(height: 28),
            Theme(
              data: ThemeData(
                primarySwatch: Colors.amber,
                unselectedWidgetColor: const Color.fromARGB(255, 117, 117, 117),
              ),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: housePicture,
                        onChanged: (bool? value) {
                          setState(() {
                            housePicture = value;
                          });
                        },
                      ),
                      const Text(
                        "Fotos da casa",
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
            ),
            const SizedBox(height: 28),
            Theme(
              data: ThemeData(
                primarySwatch: Colors.amber,
                unselectedWidgetColor: const Color.fromARGB(255, 117, 117, 117),
              ),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: previousVisit,
                        onChanged: (bool? value) {
                          setState(() {
                            previousVisit = value;
                          });
                        },
                      ),
                      const Text(
                        "Visita prévia ao animal",
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
            ),
            const SizedBox(height: 28),
            const Text(
              "SOBRE O ANIMAL",
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 247, 168, 0),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 312,
              child: TextFormField(
                controller: historyController,
                cursorWidth: 1,
                cursorColor: const Color.fromARGB(255, 247, 168, 0),
                style: const TextStyle(
                  color: Color.fromARGB(255, 189, 189, 189),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 8,
                  ),
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 230, 231, 232),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromARGB(255, 230, 231, 232),
                  )),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 247, 168, 0))),
                  hintText: "Compartilhe a história do animal",
                ),
              ),
            ),
            const SizedBox(height: 24),
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 232,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 211, 88),
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: -1,
                        blurRadius: 1,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () async {
                        try {
                          await db.collection('animal').doc().set({
                            'owner': user?.uid,
                            'photo': imageName,
                            'name': nameController.text,
                            'sickness': sicknessController.text,
                            'history': historyController.text,
                            'species': species,
                            'sex': sex,
                            'size': size,
                            'age': age,
                            'playful': playful,
                            'shy': shy,
                            'calm': calm,
                            'watchDog': watchDog,
                            'lovable': lovable,
                            'lazy': lazy,
                            'vaccinated': vaccinated,
                            'dewormed': dewormed,
                            'castrated': castrated,
                            'sick': sick,
                          });

                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushNamed("/home");
                        } catch (error) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Animal não cadastrado!'),
                          ));
                        }
                      },
                      child: const SizedBox(
                        width: 232,
                        height: 40,
                        child: Center(
                          child: Text(
                            "COLOCAR PARA ADOÇÃO",
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 67, 67, 67),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ]),
    );
  }
}
