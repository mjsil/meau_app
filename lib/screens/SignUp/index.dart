import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(255, 136, 201, 191)),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 67, 67, 67)),
        backgroundColor: const Color.fromARGB(255, 207, 233, 233),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsetsDirectional.only(start: 24, end: 24),
        children: [
          Column(
            children: [
              const SizedBox(height: 16),
              Container(
                alignment: Alignment.center,
                width: 328,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 207, 233, 229),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "As informações preenchidas serão divulgadas \n apenas para a pessoa com a qual você realizar \n o processo de adoção e/ou apadrinhamento, \n após a formalização do processo.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 67, 67, 67),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          //User Name
          const Text(
            "INFORMAÇÕES PESSOAIS",
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 88, 155, 155),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: 312,
            child: TextFormField(
              cursorColor: const Color.fromARGB(255, 136, 201, 191),
              style: const TextStyle(
                color: Color.fromARGB(255, 189, 189, 189),
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
              controller: nameController,
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
                        width: 0.8, color: Color.fromARGB(255, 230, 231, 232))),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 136, 201, 191))),
                hintText: "Nome completo",
              ),
            ),
          ),
          const SizedBox(height: 36),
          SizedBox(
            width: 312,
            child: TextFormField(
              cursorColor: const Color.fromARGB(255, 136, 201, 191),
              style: const TextStyle(
                color: Color.fromARGB(255, 189, 189, 189),
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
              controller: ageController,
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
                        width: 0.8, color: Color.fromARGB(255, 230, 231, 232))),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 136, 201, 191))),
                hintText: "Idade",
              ),
            ),
          ),
          const SizedBox(height: 36),
          SizedBox(
            width: 312,
            child: TextFormField(
              cursorColor: const Color.fromARGB(255, 136, 201, 191),
              style: const TextStyle(
                color: Color.fromARGB(255, 189, 189, 189),
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
              controller: emailController,
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
                        width: 0.8, color: Color.fromARGB(255, 230, 231, 232))),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 136, 201, 191))),
                hintText: "E-mail",
              ),
            ),
          ),
          const SizedBox(height: 36),
          SizedBox(
            width: 312,
            child: TextFormField(
              cursorColor: const Color.fromARGB(255, 136, 201, 191),
              style: const TextStyle(
                color: Color.fromARGB(255, 189, 189, 189),
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
              controller: stateController,
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
                        width: 0.8, color: Color.fromARGB(255, 230, 231, 232))),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 136, 201, 191))),
                hintText: "Estado",
              ),
            ),
          ),
          const SizedBox(height: 36),
          SizedBox(
            width: 312,
            child: TextFormField(
              cursorColor: const Color.fromARGB(255, 136, 201, 191),
              style: const TextStyle(
                color: Color.fromARGB(255, 189, 189, 189),
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
              controller: cityController,
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
                        width: 0.8, color: Color.fromARGB(255, 230, 231, 232))),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 136, 201, 191))),
                hintText: "Cidade",
              ),
            ),
          ),
          const SizedBox(height: 36),
          SizedBox(
            width: 312,
            child: TextFormField(
              cursorColor: const Color.fromARGB(255, 136, 201, 191),
              style: const TextStyle(
                color: Color.fromARGB(255, 189, 189, 189),
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
              controller: addressController,
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
                        width: 0.8, color: Color.fromARGB(255, 230, 231, 232))),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 136, 201, 191))),
                hintText: "Endereço",
              ),
            ),
          ),
          const SizedBox(height: 36),
          SizedBox(
            width: 312,
            child: TextFormField(
              cursorColor: const Color.fromARGB(255, 136, 201, 191),
              style: const TextStyle(
                color: Color.fromARGB(255, 189, 189, 189),
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
              controller: phoneController,
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
                        width: 0.8, color: Color.fromARGB(255, 230, 231, 232))),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 136, 201, 191))),
                hintText: "Telefone",
              ),
            ),
          ),
          const SizedBox(height: 28),
          //User Name
          const Text(
            "INFORMAÇÕES DE PERFIL",
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 88, 155, 155),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: 312,
            child: TextFormField(
              cursorColor: const Color.fromARGB(255, 136, 201, 191),
              style: const TextStyle(
                color: Color.fromARGB(255, 189, 189, 189),
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
              controller: usernameController,
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
                        width: 0.8, color: Color.fromARGB(255, 230, 231, 232))),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 136, 201, 191))),
                hintText: "Nome de usuário",
              ),
            ),
          ),
          const SizedBox(height: 36),
          SizedBox(
            width: 312,
            child: TextFormField(
              cursorColor: const Color.fromARGB(255, 136, 201, 191),
              style: const TextStyle(
                color: Color.fromARGB(255, 189, 189, 189),
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
              controller: passwordController,
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
                        width: 0.8, color: Color.fromARGB(255, 230, 231, 232))),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 136, 201, 191))),
                hintText: "Senha",
              ),
            ),
          ),
          const SizedBox(height: 32),
          //User Name
          const Text(
            "FOTO DE PERFIL",
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 88, 155, 155),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 32),
              Container(
                alignment: Alignment.center,
                width: 232,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 136, 201, 191),
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
                      } catch (error) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Pessoa não cadastrado!'),
                        ));
                      }
                    },
                    child: const SizedBox(
                      width: 232,
                      height: 40,
                      child: Center(
                        child: Text(
                          "FAZER CADASTRO",
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
          const SizedBox(height: 52),
        ],
      ),
    );
  }
}
