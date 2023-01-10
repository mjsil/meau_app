import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meau_app/screens/Introduction/index.dart';
import 'package:meau_app/screens/Login/index.dart';
import 'package:meau_app/services/auth/index.dart';
import 'package:meau_app/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'utils/firebase_options.dart';
import 'screens/SplashScreen/index.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthService>(
            create: (_) => AuthService(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Meau',
          initialRoute: '/',
          routes: {
            '/': (context) => const Wrapper(),
            '/intro': (context) => const IntroScreen(),
            '/login': ((context) => const LoginScreen()),
            '/home': (context) => const IntroductionScreen(),
          },
        ));
  }
}
