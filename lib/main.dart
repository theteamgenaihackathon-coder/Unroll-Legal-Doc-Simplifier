import 'package:flutter/material.dart';
import 'package:legal_doc_simplifier/views/homepage/homepage.dart';
import 'package:legal_doc_simplifier/views/loginpage/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

const Color ourRed = Color(0xFFC10547);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAuth.instance.signOut();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginView(),
        '/home': (context) => const HomePage(),
      },
      title: 'UNR0LL',
      debugShowCheckedModeBanner: false,
    );
  }
}
