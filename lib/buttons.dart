import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';

const Color ourRed = Color(0xFFC10547);

Widget cameraButton(VoidCallback onTap) {
  return IconButton(
    onPressed: onTap,
    icon: Icon(Icons.camera_alt_rounded, color: ourRed, size: 80),
  );
}

IconButton menuButton() {
  return IconButton(
    onPressed: () {},
    icon: Icon(Icons.menu_rounded, color: ourRed, size: 50),
    highlightColor: Colors.transparent,
    visualDensity: VisualDensity(horizontal: 2, vertical: -2),
  );
}

IconButton accountButton() {
  return IconButton(
    onPressed: () {},
    icon: Icon(Icons.account_circle_rounded, color: ourRed, size: 50),
    visualDensity: VisualDensity(vertical: -2),
    highlightColor: Colors.transparent,
  );
}

IconButton uploadButton() {
  return IconButton(
    onPressed: () {},
    icon: Icon(Icons.arrow_circle_up_rounded, size: 80, color: ourRed),
  );
}

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  List<File> _imageFiles = [];
  bool _isSaving = false;

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFiles.add(File(pickedFile.path));
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _imageFiles.removeAt(index);
    });
  }

  Future<File> _generatePdfToTempWithTimestamp(List<File> images) async {
    final pdf = pw.Document();

    for (final img in images) {
      final bytes = await img.readAsBytes();
      final pwImage = pw.MemoryImage(bytes);
      pdf.addPage(
        pw.Page(
          build: (_) => pw.Center(child: pw.Image(pwImage)),
        ),
      );
    }

    final tempDir = await getTemporaryDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final filePath = '${tempDir.path}/scan_$timestamp.pdf';

    final pdfFile = File(filePath);
    await pdfFile.writeAsBytes(await pdf.save());

    print('PDF saved to temp: $filePath');
    return pdfFile;
  }

  Future<void> _doneAndSaveToTemp() async {
    if (_imageFiles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No pages to save')),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final pdfFile = await _generatePdfToTempWithTimestamp(_imageFiles);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF saved to temp: ${pdfFile.path}')),
      );

      setState(() => _imageFiles.clear());

    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
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
            color: _isSaving ? Colors.grey : ourRed,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              cameraButton(_pickImageFromCamera),
              const SizedBox(height: 20),

              if (_imageFiles.isNotEmpty)
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(_imageFiles.length, (index) {
                        final file = _imageFiles[index];
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
                                  onTap: () => _removeImage(index),
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
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
