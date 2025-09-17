import 'package:flutter/material.dart';
import 'pdf_overlay.dart';
import 'dart:io';

void showPdfOverlay(
  BuildContext context, {
  required String title,
  required File pdfFile,
}) {
  final overlay = Overlay.of(context);
  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (_) => PdfOverlay(entry: entry, title: title, pdfFile: pdfFile),
  );

  overlay.insert(entry);
}
