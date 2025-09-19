import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:legal_doc_simplifier/views/homepage/menu_popup.dart';

Builder buildAccountButton() {
  return Builder(
    builder: (context) => AccountButton(
      onProfile: () {},
      onLogout: () async {
        try {
          await GoogleSignIn().signOut();
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, '/');
        } catch (e) {
          ScaffoldMessenger.of(
            // ignore: use_build_context_synchronously
            context,
          ).showSnackBar(SnackBar(content: Text("Logout failed: $e")));
        }
      },
    ),
  );
}
