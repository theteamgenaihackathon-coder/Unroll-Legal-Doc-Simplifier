import 'dart:io';
import 'package:legal_doc_simplifier/views/upload_screen/pages/preview_page/pdf_preview_page.dart';
import 'package:legal_doc_simplifier/views/upload_screen/overlays/pdf_overlay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
// import 'package:legal_doc_simplifier/views/upload_screen/show_pdf_overlay.dart';
import 'package:flutter/material.dart';

Future<File> generatePdfToTempWithTimestamp(List<File> images) async {
  final pdf = pw.Document();

  for (final img in images) {
    final bytes = await img.readAsBytes();
    final pwImage = pw.MemoryImage(bytes);
    pdf.addPage(pw.Page(build: (_) => pw.Center(child: pw.Image(pwImage))));
  }

  final tempDir = await getTemporaryDirectory();
  // final timestamp = DateTime.now().millisecondsSinceEpoch;
  final filePath = '${tempDir.path}/picked.pdf';

  final pdfFile = File(filePath);
  await pdfFile.writeAsBytes(await pdf.save());
  return pdfFile;
}

Future<void> onGeneratePressed(BuildContext context, List<File> images) async {
  final pdfFile = await generatePdfToTempWithTimestamp(images);

  // Flutter 3.7+: context.mounted, otherwise do this in a State and use `mounted`
  if (!(context.mounted)) return;
  // PdfPreviewPage(title: "Your PDF", onNext: _goNext, onBack: _goBack);

  // showPdfOverlay(context, title: 'Confirm PDF', pdfFile: pdfFile);
}
