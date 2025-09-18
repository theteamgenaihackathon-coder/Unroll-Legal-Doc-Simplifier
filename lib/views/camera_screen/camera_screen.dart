import 'dart:io';
import 'package:flutter/material.dart';
import 'package:legal_doc_simplifier/views/camera_screen/image_preview.dart';
import 'package:legal_doc_simplifier/views/camera_screen/pdf_generator.dart';
import 'package:legal_doc_simplifier/views/camera_screen/pick_camera_image.dart';
import 'package:legal_doc_simplifier/views/homepage/camera_button.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final List<File> _imageFiles = [];
  bool _isSaving = false;

  Future<void> _handlePickImage() async {
    final imageFile = await pickImageFromCamera();
    if (imageFile != null) {
      setState(() => _imageFiles.add(imageFile));
    }
  }

  void _handleRemoveImage(int index) {
    setState(() => removeImageAt(_imageFiles, index));
  }

  Future<void> _doneAndSaveToTemp() async {
    if (_imageFiles.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('No pages to save')));
      return;
    }

    setState(() => _isSaving = true);

    try {
      final pdfFile = await generatePdfToTempWithTimestamp(_imageFiles);
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF saved to temp: ${pdfFile.path}')),
      );

      setState(() => _imageFiles.clear());
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _isSaving = false);
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
            onPressed: _isSaving ? null : _doneAndSaveToTemp,
            color: _isSaving ? Colors.grey : Colors.red,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CameraButton(onPressed: _handlePickImage),
              const SizedBox(height: 20),
              if (_imageFiles.isNotEmpty)
                Expanded(
                  child: ImagePreviewRow(
                    imageFiles: _imageFiles,
                    onRemove: _handleRemoveImage,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
