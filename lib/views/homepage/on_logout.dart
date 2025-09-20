import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void googleLogOut(BuildContext context) async {
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
}
