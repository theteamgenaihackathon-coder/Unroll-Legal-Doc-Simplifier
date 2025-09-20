import 'package:flutter/material.dart';
import 'package:legal_doc_simplifier/network/authentication.dart';

const Color softPink = Color.fromARGB(255, 245, 185, 192);

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  void showError(BuildContext context, Object error) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Google Sign-In failed: $error')));
  }

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: softPink,
      foregroundColor: Colors.black,
      minimumSize: const Size(double.infinity, 48),
      side: BorderSide(color: Colors.grey.shade300),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );

    return ElevatedButton.icon(
      style: buttonStyle,
      icon: Image.asset('assets/icons/google_logo.png', height: 20),
      label: const Text('Continue with Google'),
      onPressed: () async {
        try {
          await signInWithGoogle();
          Navigator.pushReplacementNamed(context, '/home');
        } catch (e) {
          showError(context, e);
        }
      },
    );
  }
}
