import 'package:flutter/material.dart';
import 'package:legal_doc_simplifier/views/homepage/account_button_builder.dart';
import 'package:legal_doc_simplifier/views/homepage/homebody.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        surfaceTintColor: Colors.transparent,
        elevation: 2,
        shadowColor: Colors.black.withAlpha(200),
        title: const Text("Unroll"),
        centerTitle: true,
        actions: [buildAccountButton()],
      ),

      body: const HomeBody(),
      backgroundColor: Colors.white,
    );
  }
}
