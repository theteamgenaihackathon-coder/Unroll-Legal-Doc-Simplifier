import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

void googleLogOut(BuildContext context) async {
  try {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut(); // Sign out from Firebase

    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/');
  } catch (e) {
    ScaffoldMessenger.of(
      // ignore: use_build_context_synchronously
      context,
    ).showSnackBar(SnackBar(content: Text("Logout failed: $e")));
  }
}
