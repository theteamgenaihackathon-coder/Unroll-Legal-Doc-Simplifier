import 'package:flutter/material.dart';

const Color ourRed = Color(0xFFC10547);

class CameraButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CameraButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.camera_alt_rounded, color: ourRed, size: 80),
      onPressed: onPressed,
    );
  }
}
