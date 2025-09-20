import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';

Future<File> generatePdfToTempWithTimestamp(List<File> images) async {
  final pdf = pw.Document();

  for (final img in images) {
    final bytes = await img.readAsBytes();
    final pwImage = pw.MemoryImage(bytes);
    pdf.addPage(pw.Page(build: (_) => pw.Center(child: pw.Image(pwImage))));
  }

  final tempDir = await getTemporaryDirectory();
  final filePath = '${tempDir.path}/picked.pdf';

  final pdfFile = File(filePath);
  await pdfFile.writeAsBytes(await pdf.save());
  return pdfFile;
}

Future<void> onGeneratePressed(BuildContext context, List<File> images) async {
  await generatePdfToTempWithTimestamp(images);

  if (!(context.mounted)) return;
}
