import 'package:flutter/material.dart';
import 'package:legal_doc_simplifier/views/homepage/homepage.dart';

ElevatedButton guestButton(BuildContext context) {
  return ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.grey.shade100,
      foregroundColor: Colors.black,
      minimumSize: Size(double.infinity, 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    icon: Icon(Icons.person_outline),
    label: Text('Continue as guest'),
    onPressed: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    },
  );
}
