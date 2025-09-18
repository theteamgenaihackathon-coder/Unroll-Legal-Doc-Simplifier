import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

const Color ourRed = Color(0xFFC10547);


Widget cameraButton(Function(List<File>) onDoneCapturing) {
  return IconButton(
    icon: Icon(Icons.camera_alt_rounded, color: ourRed, size: 80),
    onPressed: () async {
      final picker = ImagePicker();
      final List<File> capturedImages = [];
      bool capturing = true;

      while (capturing) {
        final pickedFile = await picker.pickImage(source: ImageSource.camera);
        if (pickedFile != null) {
          final imageFile = File(pickedFile.path);
          capturedImages.add(imageFile);
        } else {
          capturing = false;
          break;
        }

        capturing =
            await showDialog<bool>(
              context: navigatorKey.currentContext!,
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
            ) ??
            false;
      }

      // ✅ Now generate PDF only after user says "No"
      if (capturedImages.isNotEmpty) {
        onDoneCapturing(capturedImages);
      }
    },
  );
}

// Add this somewhere globally (e.g., main.dart)
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
