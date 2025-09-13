import 'package:flutter/material.dart';
import 'package:legal_doc_simplifier/login_view.dart';
import 'package:legal_doc_simplifier/widgets.dart';

const Color ourRed = Color(0xFFC10547);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      // home: HomePage(),
      home: LoginView(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: myBody(context),
      backgroundColor: Colors.white,
    );
  }
}
