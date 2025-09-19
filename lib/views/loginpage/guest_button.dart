import 'package:flutter/material.dart';

class GuestButton extends StatelessWidget {
  const GuestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey.shade100,
        foregroundColor: Colors.black,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: const Icon(Icons.person_outline),
      label: const Text('Continue as guest'),
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/home');
      },
    );
  }
}
