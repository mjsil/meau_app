import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../AddAnimalPhoto/index.dart';

class AnimalRegistryScreen extends StatelessWidget {
  const AnimalRegistryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Cadastro do Animal';

    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      body: const MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  AnimalRegistry createState() {
    return AnimalRegistry();
  }
}

class AnimalRegistry extends State {
  //Instancia Firestore
  FirebaseFirestore db = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _sicknessController = TextEditingController();
  final _prescriptionController = TextEditingController();
  final _objectsController = TextEditingController();
  final _historyController = TextEditingController();

  String? species;

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
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          //Nome do animal Text Field
          const SizedBox(height: 20),
          const Text('NOME DO ANIMAL'),
          const SizedBox(height: 20),
          TextFormField(
            controller: _nameController,
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
            controller: _sicknessController,
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
            controller: _prescriptionController,
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
            controller: _objectsController,
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
            controller: _historyController,
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
              onPressed: () => sendData(),
              child: const Text("CADASTRAR"),
            ),
          ),
        ],
      ),
    );
  }

  void sendData() {
    String id = const Uuid().v1();

    db.collection('animal').doc(id).set({
      //text controller
      'name': _nameController.text,
      'sickness': _sicknessController.text,
      'prescription': _prescriptionController.text,
      'objects': _objectsController.text,
      'History': _historyController.text,
      //radio and checkbox controller
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

    const snackBar = SnackBar(
      content: Text('Salvo!'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
