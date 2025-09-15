import 'package:flutter/material.dart';

const Color ourRed = Color(0xFFC10547);

IconButton uploadButton() {
  return IconButton(
    onPressed: () {},
    icon: Icon(Icons.arrow_circle_up_rounded, size: 80, color: ourRed),
  );
}

IconButton cameraButton() {
  return IconButton(
    onPressed: () {},
    icon: Icon(Icons.camera_alt_rounded, color: ourRed, size: 80),
  );
}
