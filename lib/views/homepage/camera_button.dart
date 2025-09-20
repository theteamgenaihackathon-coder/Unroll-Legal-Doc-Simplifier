import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:legal_doc_simplifier/views/homepage/capture_images.dart';

const Color ourRed = Color(0xFFC10547);

class CameraButton extends ConsumerWidget {
  const CameraButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.camera_alt_rounded, color: ourRed, size: 80),
      onPressed: () => captureImages(context, ref),
    );
  }
}
