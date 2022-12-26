import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user/index.dart';
import '../../services/auth/index.dart';
import '../AddAnimalPhoto/index.dart';

class AnimalRegistryScreen extends StatelessWidget {
  const AnimalRegistryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return StreamBuilder<User?>(
        stream: authService.user,
        builder: (_, AsyncSnapshot<User?> snapshot) {
          final User? user = snapshot.data;

          return MyCustomForm(
            uid: user?.uid,
          );
        });
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key, required this.uid});

  final String? uid;

  @override
  AnimalRegistry createState() {
    return AnimalRegistry();
  }
}

class AnimalRegistry extends State<MyCustomForm> {
  //Instancia Firestore
  FirebaseFirestore db = FirebaseFirestore.instance;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController sicknessController = TextEditingController();
  final TextEditingController prescriptionController = TextEditingController();
  final TextEditingController objectsController = TextEditingController();
  final TextEditingController historyController = TextEditingController();

  String? species;
  String? sex;
  String? size;

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

  //animal needs
  bool? foodHelp = false;
  bool? moneyHelp = false;
  bool? medicationHelp = false;

  //objects
  bool? object = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(children: <Widget>[
          //Nome do animal Text Field
          const SizedBox(height: 20),
          const Text('NOME DO ANIMAL'),
          const SizedBox(height: 20),
          TextFormField(
            controller: nameController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                hintText: "Nome do animal",
                contentPadding: EdgeInsets.all(8),
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                )),
          ),

          //add image container
          const SizedBox(height: 20),
          const Text('FOTOS DO ANIMAL'),
          const SizedBox(height: 20),
          Container(
            height: 150,
            width: 380,
            decoration: BoxDecoration(
              color: const Color(0xfff1f2f2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AddPhotoScreenAnimal()),
                        ),
                    icon: const Icon(Icons.control_point,
                        color: Color(0Xff434343))),
                const Text(
                  "Adicionar fotos",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0Xff434343)),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 15),
          ),

          //species
          const SizedBox(height: 20),
          const Text('ESPÉCIE'),
          const SizedBox(height: 20),
          Row(
            children: [
              Radio(
                value: "cachorro",
                groupValue: species,
                onChanged: (value) {
                  setState(() {
                    species = value.toString();
                  });
                },
              ),
              const Text("Cachorro"),
              Radio(
                value: "gato",
                groupValue: species,
                onChanged: (value) {
                  setState(() {
                    species = value.toString();
                  });
                },
              ),
              const Text("Gato"),
            ],
          ),
          //sex
          const SizedBox(height: 20),
          const Text('SEXO'),
          const SizedBox(height: 20),
          Row(
            children: [
              Radio(
                value: "Macho",
                groupValue: sex,
                onChanged: (value) {
                  setState(() {
                    sex = value.toString();
                  });
                },
              ),
              const Text("Macho"),
              Radio(
                value: "Fêmea",
                groupValue: sex,
                onChanged: (value) {
                  setState(() {
                    sex = value.toString();
                  });
                },
              ),
              const Text("Fêmea"),
            ],
          ),
          //sex
          const SizedBox(height: 20),
          const Text('PORTE'),
          const SizedBox(height: 20),
          Row(
            children: [
              Radio(
                value: "Pequeno",
                groupValue: size,
                onChanged: (value) {
                  setState(() {
                    size = value.toString();
                  });
                },
              ),
              const Text("Pequeno"),
              Radio(
                value: "Médio",
                groupValue: size,
                onChanged: (value) {
                  setState(() {
                    size = value.toString();
                  });
                },
              ),
              const Text("Médio"),
              Radio(
                value: "Grande",
                groupValue: size,
                onChanged: (value) {
                  setState(() {
                    size = value.toString();
                  });
                },
              ),
              const Text("Grande"),
            ],
          ),

          //temper 1
          const SizedBox(height: 20),
          const Text('TEMPERAMENTO'),
          const SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                value: playful,
                onChanged: (bool? value) {
                  setState(() {
                    playful = value;
                  });
                },
              ),
              const Text("Brincalhão"),
              Checkbox(
                value: shy,
                onChanged: (bool? value) {
                  setState(() {
                    shy = value;
                  });
                },
              ),
              const Text("Tímido"),
              Checkbox(
                value: calm,
                onChanged: (bool? value) {
                  setState(() {
                    calm = value;
                  });
                },
              ),
              const Text("Calmo"),
            ],
          ),
          const SizedBox(height: 20),
          //temper 2
          Row(
            children: [
              Checkbox(
                value: watchDog,
                onChanged: (bool? value) {
                  setState(() {
                    watchDog = value;
                  });
                },
              ),
              const Text("Guarda"),
              Checkbox(
                value: lovable,
                onChanged: (bool? value) {
                  setState(() {
                    lovable = value;
                  });
                },
              ),
              const Text("Amoroso"),
              Checkbox(
                value: lazy,
                onChanged: (bool? value) {
                  setState(() {
                    lazy = value;
                  });
                },
              ),
              const Text("Preguiçoso"),
            ],
          ),
          //health 1

          const SizedBox(height: 20),
          const Text('SAÚDE'),
          const SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                value: vaccinated,
                onChanged: (bool? value) {
                  setState(() {
                    vaccinated = value;
                  });
                },
              ),
              const Text("Vacinado"),
              Checkbox(
                value: dewormed,
                onChanged: (bool? value) {
                  setState(() {
                    dewormed = value;
                  });
                },
              ),
              const Text("Vermifugado"),
            ],
          ),
          const SizedBox(height: 20),
          //health 2
          Row(
            children: [
              Checkbox(
                value: castrated,
                onChanged: (bool? value) {
                  setState(() {
                    castrated = value;
                  });
                },
              ),
              const Text("Castrado"),
              Checkbox(
                value: sick,
                onChanged: (bool? value) {
                  setState(() {
                    sick = value;
                  });
                },
              ),
              const Text("Doente"),
            ],
          ),
          TextFormField(
            controller: sicknessController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                hintText: "Doenças do animal",
                contentPadding: EdgeInsets.all(8),
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                )),
          ),
          //animal needs
          const SizedBox(height: 20),
          const Text('NECESSIDADES DO ANIMAL'),
          const SizedBox(height: 20),

          //foodHelp
          Row(
            children: [
              Checkbox(
                value: foodHelp,
                onChanged: (bool? value) {
                  setState(() {
                    foodHelp = value;
                  });
                },
              ),
              const Text("Alimento"),
            ],
          ),

          //moneyHelp
          Row(
            children: [
              Checkbox(
                value: moneyHelp,
                onChanged: (bool? value) {
                  setState(() {
                    moneyHelp = value;
                  });
                },
              ),
              const Text("Auxílio financeiro"),
            ],
          ),
          //medicationHelp
          Row(
            children: [
              Checkbox(
                value: medicationHelp,
                onChanged: (bool? value) {
                  setState(() {
                    medicationHelp = value;
                  });
                },
              ),
              const Text("Medicamento"),
            ],
          ),
          //prescription
          TextFormField(
            controller: prescriptionController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                hintText: "Nome do medicamento",
                contentPadding: EdgeInsets.all(8),
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                )),
          ),
          //objects
          Row(
            children: [
              Checkbox(
                value: object,
                onChanged: (bool? value) {
                  setState(() {
                    object = value;
                  });
                },
              ),
              const Text("Objetos"),
            ],
          ),
          //text field object
          TextFormField(
            controller: objectsController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                hintText: "Especifique o(s) objetos(s)",
                contentPadding: EdgeInsets.all(8),
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                )),
          ),
          //animal history
          const SizedBox(height: 20),
          const Text('SOBRE O ANIMAL'),
          const SizedBox(height: 20),
          TextFormField(
            controller: historyController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                hintText: "Compartilher a história do animal",
                contentPadding: EdgeInsets.all(8),
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                )),
          ),
          //register animal button
          const SizedBox(height: 52),
          SizedBox(
            width: 232,
            height: 40,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                textStyle: const TextStyle(
                  fontSize: 12,
                ),
              ),
              onPressed: () async {
                try {
                  await db.collection('animal').doc().set({
                    'owner': widget.uid,
                    'name': nameController.text,
                    'sickness': sicknessController.text,
                    'prescription': prescriptionController.text,
                    'objects': objectsController.text,
                    'history': historyController.text,
                    'species': species,
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
                    'foodHelp': foodHelp,
                    'moneyHelp': moneyHelp,
                    'medicationHelp': medicationHelp,
                    'object': object,
                  });

                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushNamed("/home");
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Animal não cadastrado!'),
                  ));
                }
              },
              child: const Text("CADASTRAR"),
            ),
          ),
        ]),
      ),
    );
  }
}
