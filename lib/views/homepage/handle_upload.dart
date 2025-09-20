import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:legal_doc_simplifier/views/homepage/home_providers.dart';

Future<void> handlePdfUpload(BuildContext context, WidgetRef ref) async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );

  if (result != null && result.files.single.path != null) {
    final pickedFile = File(result.files.single.path!);
    ref.read(currentPageProvider.notifier).state = 1;

    final tempDir = await getTemporaryDirectory();
    final tempPath = '${tempDir.path}/picked.pdf';
    await pickedFile.copy(tempPath);
  } else {
    debugPrint('No file selected');
  }
}
