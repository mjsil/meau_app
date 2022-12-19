import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddPhotoScreenAnimal extends StatelessWidget {
  const AddPhotoScreenAnimal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pegar Imagem',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyAnimalPhotoSelector(title: 'Pegar Imagem'),
    );
  }
}

class MyAnimalPhotoSelector extends StatefulWidget {
  const MyAnimalPhotoSelector({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  State<MyAnimalPhotoSelector> createState() => _MyAnimalPhotoSelector();
}

class _MyAnimalPhotoSelector extends State<MyAnimalPhotoSelector> {
  File? image;
  final FirebaseStorage storage = FirebaseStorage.instance;
  bool uploading = false;
  double total = 0;

  Future<XFile?> getImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    //UploadTask task = await upload(image.path);
    return image;
  }

  Future<UploadTask> upload(String path) async {
    File file = File(path);
    try {
      String ref = 'animal/img-${DateTime.now().toString()}.jpg';
      return storage.ref(ref).putFile(file);
    } on FirebaseException catch (e) {
      throw Exception('Erro no upload: ${e.code}');
    }
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);
      UploadTask task = await upload(image.path);

      task.snapshotEvents.listen((TaskSnapshot snapshot) async {
        if (snapshot.state == TaskState.running) {
          setState(() {
            uploading = true;
            total = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          });
        } else if (snapshot.state == TaskState.success) {
          setState(() => uploading = false);
        }
      });

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

      UploadTask task = await upload(image.path);

      task.snapshotEvents.listen((TaskSnapshot snapshot) async {
        if (snapshot.state == TaskState.running) {
          setState(() {
            uploading = true;
            total = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          });
        } else if (snapshot.state == TaskState.success) {
          setState(() => uploading = false);
        }
      });

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: uploading
                ? Text('${total.round()}% enviado')
                : const Text("Pegar Imagem"),
            actions: [
              uploading
                  ? const Padding(
                      padding: EdgeInsets.only(right: 12.0),
                      child: Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : IconButton(
                      icon: const Icon(Icons.upload),
                      onPressed: (() async {
                        print('ÍCONE PRESSIONADO.');
                      }),
                    )
            ]),
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
