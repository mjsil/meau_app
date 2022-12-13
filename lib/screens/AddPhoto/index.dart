import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AddPhotoScreen extends StatelessWidget {
  const AddPhotoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pegar Imagem',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyPhotoSelector(title: 'Pegar Imagem'),
    );
  }
}

class MyPhotoSelector extends StatefulWidget {
  const MyPhotoSelector({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyPhotoSelector> createState() => _MyPhotoSelectorState();
}

class _MyPhotoSelectorState extends State<MyPhotoSelector> {
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Pegar Imagem"),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
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
                  onPressed: () => pickImage(),
                  child: const Text("Pegar Imagem Da Galeria"),
                ),
              ),
              const SizedBox(height: 20),
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
                  onPressed: () => pickImageC(),
                  child: const Text("Pegar Imagem Da Câmera"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              image != null
                  ? Image.file(image!)
                  : const Text("Imagem não selecionada")
            ],
          ),
        ));
  }
}
