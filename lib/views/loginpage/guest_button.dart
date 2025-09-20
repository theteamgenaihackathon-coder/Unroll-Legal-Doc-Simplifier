import 'package:flutter/material.dart';

class GuestButton extends StatelessWidget {
  const GuestButton({super.key});

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: Colors.grey.shade100,
      foregroundColor: Colors.black,
      minimumSize: const Size(double.infinity, 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
    return ElevatedButton.icon(
      style: buttonStyle,
      icon: const Icon(Icons.person_outline),
      label: const Text('Continue as guest'),
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/home');
      },
    );
  }
}
