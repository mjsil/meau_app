import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meau_app/services/message/index.dart';
import 'package:meau_app/widgets/Message/index.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatScreen> {
  Stream<QuerySnapshot>? chats;
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    getChatandAdmin();
    super.initState();
  }

  getChatandAdmin() {
    DatabaseService().getChats('zH3rBdIPnNEDFoqO0H1v').then((val) {
      setState(() {
        chats = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 242, 242, 1),
      appBar: AppBar(
        title: const Text('Chat',
          style: TextStyle(
            color: Color.fromARGB(255, 67, 67, 67),
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(255, 88, 155, 155)),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 67, 67, 67)),
        backgroundColor: const Color.fromARGB(255, 136, 201, 191),
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          // chat messages
          chatMessages('${user?.uid}'),
          
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              width: MediaQuery.of(context).size.width,
              child: Row(children: [
                Expanded(
                  child: TextFormField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: "Enviar mensagem...",
                      hintStyle: TextStyle(color: Color.fromARGB(255, 67, 67, 67), fontSize: 16),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  )
                ),
                const SizedBox(
                  width: 12,
                ),
                GestureDetector(
                  onTap: () {
                    sendMessage('${user?.uid}');
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 136, 201, 191),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                        child: Icon(
                      Icons.send,
                      color: Colors.white,
                    )),
                  ),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }

  chatMessages(String uid) {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return Message(
                    message: snapshot.data.docs[index]['message'],
                    sentByMe: uid ==
                      snapshot.data.docs[index]['sender']);
                },
              )
            : Container();
      },
    );
  }

  sendMessage(String uid) {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageController.text,
        "sender": uid,
        "time": DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseService().sendMessage('zH3rBdIPnNEDFoqO0H1v', chatMessageMap);

      setState(() {
        messageController.clear();
      });
    }
  }
}