import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:legal_doc_simplifier/views/homepage/menu_popup.dart';
import 'package:legal_doc_simplifier/views/loginpage/login_view.dart';

Builder buildAccountButton() {
  return Builder(
    builder: (context) => AccountButton(
      onProfile: () {
        print('Profile tapped');
      },
      onLogout: () async {
        try {
          // await signOutFromGoogle(); // your helper method
          await GoogleSignIn().signOut();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginView()),
          );
        } catch (e) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Logout failed: $e")));
        }
      },
    ),
  );
}
