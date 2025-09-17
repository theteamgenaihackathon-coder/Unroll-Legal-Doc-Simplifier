import 'package:flutter/material.dart';
import 'package:legal_doc_simplifier/views/homepage/homepage.dart';
import 'package:legal_doc_simplifier/views/loginpage/login_view.dart';

ElevatedButton googleButton(BuildContext context) {
  return ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      backgroundColor: softPink,
      foregroundColor: Colors.black,
      minimumSize: Size(double.infinity, 48),
      side: BorderSide(color: Colors.grey.shade300),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    // icon: Image.asset('assets/google_logo.png', height: 20),
    icon: Image.asset('assets/icons/google_logo.png', height: 20),
    label: Text('Continue with Google'),
    onPressed: () async {
      try {
        await signInWithGoogle();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Google Sign-In failed: $e")),
        ); //to reverse, when logout is clicked, it should return to the opening page
      }
      // TODO: Handle Google Sign-In
    },
  );
}
