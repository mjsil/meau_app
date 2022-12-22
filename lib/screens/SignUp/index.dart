import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth/index.dart';
import '../AddPeoplePhoto/index.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    final TextEditingController nameController = TextEditingController();
    final TextEditingController ageController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController stateController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();

    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      appBar: AppBar(
        title: const Text(
          "Cadastro Pessoal",
          style: TextStyle(
            color: Color.fromARGB(255, 67, 67, 67),
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20),
            const Text("INFORMAÇÕES PESSOAIS"),
            const SizedBox(height: 20),
            TextFormField(
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  hintText: "Nome completo",
                  contentPadding: EdgeInsets.all(8),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  )),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: "Idade",
                  contentPadding: EdgeInsets.all(8),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  )),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  hintText: "E-mail",
                  contentPadding: EdgeInsets.all(8),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  )),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: stateController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  hintText: "Estado",
                  contentPadding: EdgeInsets.all(8),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  )),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: cityController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  hintText: "Cidade",
                  contentPadding: EdgeInsets.all(8),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  )),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: addressController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  hintText: "Endereço",
                  contentPadding: EdgeInsets.all(8),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  )),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: "Telefone",
                  contentPadding: EdgeInsets.all(8),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  )),
            ),
            const SizedBox(height: 20),
            const Text("INFORMAÇÕES DE PERFIL"),
            const SizedBox(height: 20),
            TextFormField(
              controller: usernameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  hintText: "Nome de usuário",
                  contentPadding: EdgeInsets.all(8),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  )),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: const InputDecoration(
                  hintText: "Senha",
                  contentPadding: EdgeInsets.all(8),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  )),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: confirmPasswordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Confirmar senha",
                contentPadding: EdgeInsets.all(8),
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("FOTO DE PERFIL"),
            const SizedBox(height: 20),
            Container(
              height: 128,
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
                          const AddPhotoScreenPeople(),
                      ),
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
            const SizedBox(height: 52),
            SizedBox(
              width: 232,
              height: 40,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.black,
                  textStyle: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                onPressed: () async {
                  try {
                    await authService.createUserWithEmailAndPassword(
                      emailController.text, 
                      passwordController.text,
                      nameController.text,
                      ageController.text,
                      stateController.text,
                      cityController.text,
                      addressController.text,
                      phoneController.text,
                      usernameController.text,
                    ); 

                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushNamed("/login");
                  } catch(error) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Pessoa não cadastrado!'),
                    ));
                  } 
                }, 
                child: const Text("FAZER CADASTRO"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
