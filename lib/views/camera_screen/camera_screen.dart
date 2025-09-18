import 'dart:io';
import 'package:flutter/material.dart';
import 'package:legal_doc_simplifier/views/camera_screen/image_preview.dart';
import 'package:legal_doc_simplifier/views/camera_screen/pdf_generator.dart';
import 'package:legal_doc_simplifier/views/homepage/camera_button.dart';
import 'package:path_provider/path_provider.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final List<File> _imageFiles = [];
  bool _isSaving = false;

  void _addImage(File imageFile) {
    setState(() => _imageFiles.add(imageFile));
  }

  void _removeImage(int index) {
    setState(() => _imageFiles.removeAt(index));
  }

  Future<void> _saveAsPdf() async {
    if (_imageFiles.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('No images to save')));
      return;
    }

    setState(() => _isSaving = true);

    try {
      final pdfFile = await generatePdfToTemp(_imageFiles);
      final externalDir = await getTemporaryDirectory();
      final visiblePath = '${externalDir.path}/scanned.pdf';
      await pdfFile.copy(visiblePath);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('PDF saved at: $visiblePath')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera to PDF'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: _isSaving ? null : _saveAsPdf,
            color: _isSaving ? Colors.grey : Colors.red,
          ),
        ],
      ),
      body: Column(
        children: [
          cameraButton((List<File> files) {
            for (final file in files) {
              _addImage(file);
            }
          }),

          const SizedBox(height: 20),
          if (_imageFiles.isNotEmpty)
            Expanded(
              child: ImagePreviewRow(
                imageFiles: _imageFiles,
                onRemove: _removeImage,
              ),
            ),
        ],
      ),
    );
  }
}
