import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:legal_doc_simplifier/main.dart';
import 'package:legal_doc_simplifier/views/homepage/handle_upload.dart';

class UploadButton extends ConsumerWidget {
  const UploadButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.arrow_circle_up_rounded, size: 80, color: ourRed),
      onPressed: () => handlePdfUpload(context, ref),
    );
  }
}
