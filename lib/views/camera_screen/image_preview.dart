import 'dart:io';
import 'package:flutter/material.dart';

class ImagePreviewRow extends StatelessWidget {
  final List<File> imageFiles;
  final void Function(int) onRemove;

  const ImagePreviewRow({
    Key? key,
    required this.imageFiles,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(imageFiles.length, (index) {
          final file = imageFiles[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Image.file(file, height: 100),
                Positioned(
                  top: -8,
                  right: -8,
                  child: GestureDetector(
                    onTap: () => onRemove(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFC0CB).withOpacity(0.7),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(4),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
