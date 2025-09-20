// To be used as function file from camera button
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:legal_doc_simplifier/views/camera_screen/pdf_generator.dart';
import 'package:legal_doc_simplifier/views/homepage/home_providers.dart';

Future<void> captureImages(BuildContext context, WidgetRef ref) async {
  final picker = ImagePicker();
  final List<File> images = [];

  while (true) {
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked == null) break;

    images.add(File(picked.path));

    final addMore = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add another image?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );

    if (addMore != true) break;
  }

  if (images.isNotEmpty) {
    final pdf = await generatePdfToTemp(images);
    if (pdf.existsSync()) {
      ref.read(currentPageProvider.notifier).state = 1;
    }
  }
}
