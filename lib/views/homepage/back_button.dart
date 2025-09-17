import 'package:flutter/material.dart';

const Color ourRed = Color(0xFFC10547);

IconButton backButton(VoidCallback onPressed) {
  return IconButton(
    onPressed: onPressed,
    icon: Icon(Icons.arrow_back_ios_new_rounded, color: ourRed, size: 30),
  );
}
