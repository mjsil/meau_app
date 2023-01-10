import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:core';

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class AnimalDetailScreen extends StatefulWidget {
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

  //owner
  final String owner;

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
    //owner
    required this.owner,
  }) : super(key: key);

  @override
  State<AnimalDetailScreen> createState() => _AnimalDetailScreenState();
}

class _AnimalDetailScreenState extends State<AnimalDetailScreen> {
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  String? token = " ";
  String? address = " ";
  String? city = " ";

  @override
  void initState() {
    super.initState();

    requestPermission();

    loadFCM();

    listenFCM();

    getPeopleInfo();

    // getToken();

    //FirebaseMessaging.instance.subscribeToTopic("Animal");
  }

  void getPeopleInfo() async {
    //final User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("people")
        .doc(widget.owner)
        .get();

    setState(() {
      token = snap['token'];
      address = snap['address'];
      city = snap['city'];
    });
  }

  // void getToken() async {
  //   await FirebaseMessaging.instance.getToken().then((token) {
  //     setState(() {
  //       token = token;
  //     });
  //   });
  // }

  void sendPushMessage(String token) async {
    // FirebaseMessaging firebaseMessage = FirebaseMessaging.instance;
    // String? deviceToken = await firebaseMessage.getToken();
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAu2sjcYc:APA91bEmdLSWh8ZFYBF6sviOcb-pVwG_m_q4UxJeaySxss6TJiZkBhKhRJm7Le7IzKeTrmBRpc1lb5o4Whfy0E0rScTvBp6cXy4oRolRSyjcDX9JtEB67Neo3Z8Me107wpYdGSUru6M-',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              //'title': 'alguém pretende adotar o(a) ${widget.name}',
              'body': 'alguém pretende adotar ${widget.name}',
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
            // "to": "$deviceToken",
            // "to":
            //     "e8z3oWLiTbma6KqWCaY_U5:APA91bEubU54kCiyKlDMjhFl695PHPr2bCqPSYx6VJ7dyBU7x8HLUQpu2VKDHcb4LdOQd32fFI2G9FNsTpqaXKkv53wgW44r0opnZzLDtKxsLfxbaAq6merWlSWCF5_j0FnlybZqYQkD",
          },
        ),
      );
    } catch (e) {
      print("error push notification");
    }
  }

  // void getToken() async {
  //   await FirebaseMessaging.instance.getToken().then((token) => print(token));
  // }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: '@mipmap/launcher_icon',
            ),
          ),
        );
      }
    });
  }

  void loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

//   void selectNotification() async {
// // Here you can check notification payload and redirect user to the respective screen
//     await Navigator.push(
//       context,
//       MaterialPageRoute<void>(
//           builder: (context) => const InterestedMyAnimalScreen()),
//     );
//   }

  Future<void> saveTokenToDatabase(String deviceToken) async {
    // Assume user is logged in for this example
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    await FirebaseFirestore.instance.collection('people').doc(userId).update({
      'tokens': FieldValue.arrayUnion([deviceToken]),
    });
  }

  void sendPeoplePushMessage() async {}

  @override
  Widget build(BuildContext context) {
    List<String> temperText = [
      (widget.playful ? "brincalhão" : ""),
      (widget.shy ? "tímido" : ""),
      (widget.calm ? "calmo" : ""),
      (widget.watchDog ? "guarda" : ""),
      (widget.lovable ? "amoroso" : ""),
      (widget.lazy ? "preguiçoso" : ""),
    ];

    List<String> adoptRequirementText = [
      (widget.adoptionTerm ? "termo de adoção" : ""),
      (widget.housePicture ? "fotos da casa" : ""),
      (widget.previousVisit ? "visita prévia" : ""),
    ];

    temperText.removeWhere((item) => item == "");
    adoptRequirementText.removeWhere((item) => item == "");

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      appBar: AppBar(
        title: Text(
          widget.name,
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
                          image: NetworkImage(widget.pictureUrl),
                          fit: BoxFit.cover),
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
                  widget.name,
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
                          widget.sex.capitalize(),
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
                          widget.size.capitalize(),
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
                          widget.age.capitalize(),
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
                      children: [
                        const Text(
                          "LOCALIZAÇÃO",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 247, 168, 0),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${address!.toUpperCase()} - ${city!.toUpperCase()}",
                          style: const TextStyle(
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
                          widget.castrated ? "Sim" : "Não",
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
                          widget.vaccinated ? "Sim" : "Não",
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
                          widget.dewormed ? "Sim" : "Não",
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
                          widget.sick ? "Doente" : "Nenhuma",
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
                      "MAIS SOBRE ${widget.name.toUpperCase()}",
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 247, 168, 0),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.history,
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
                        onTap: () async {
                          sendPushMessage(token!);
                        },
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
