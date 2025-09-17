import 'package:flutter/material.dart';

const Color ourRed = Color(0xFFC10547);

Widget cameraButton(VoidCallback onTap) {
  return IconButton(
    onPressed: onTap,
    icon: Icon(Icons.camera_alt_rounded, color: ourRed, size: 80),
  );
}
