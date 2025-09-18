import 'package:flutter/material.dart';

const Color ourRed = Color(0xFFC10547);

IconButton exampleButton(VoidCallback onTap) {
  return IconButton(
    onPressed: onTap,
    icon: const Icon(Icons.question_answer_rounded),
    color: const Color.fromARGB(255, 255, 117, 129),
  );
}
