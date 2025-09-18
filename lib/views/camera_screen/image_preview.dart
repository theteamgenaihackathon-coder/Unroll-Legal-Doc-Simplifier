import 'dart:io';
import 'package:flutter/material.dart';

class ImagePreviewRow extends StatelessWidget {
  final List<File> imageFiles;
  final Function(int) onRemove;

  const ImagePreviewRow({
    required this.imageFiles,
    required this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: imageFiles.length,
      itemBuilder: (context, index) {
        final file = imageFiles[index];
        return Stack(
          children: [
            Image.file(file, width: 150, fit: BoxFit.cover),
            Positioned(
              top: 4,
              right: 4,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () => onRemove(index),
              ),
            ),
          ],
        );
      },
    );
  }
}
