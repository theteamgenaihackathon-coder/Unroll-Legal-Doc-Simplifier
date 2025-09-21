import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        backgroundColor: const Color.fromARGB(
          255,
          239,
          144,
          154,
        ), // light pink-peach tone,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        surfaceTintColor: Colors.transparent,
        elevation: 2,
        shadowColor: Colors.black.withAlpha(200),
        title: Text(
          'UNROLL',
          style: GoogleFonts.poppins(
            fontSize: 40,
            fontWeight: FontWeight.w600,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        // titleTextStyle: TextStyle(
        //   fontSize: 20,
        //   fontWeight: FontWeight.bold,
        //   fontFamily: "Nunito",
        // ),
        centerTitle: true,
        actions: [
          const SizedBox(width: 0), // spacing before the button
          buildAccountButton(),
          const SizedBox(width: 0), // spacing after the button
        ],
      ),

      body: const HomeBody(),
      backgroundColor: const Color(0xFFFFD6DC), // light pink-peach tone,
    );
  }
}
