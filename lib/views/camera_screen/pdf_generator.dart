import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:ui';

Future<File> generatePdfToTemp(List<File> images) async {
  final document = PdfDocument();

  for (final img in images) {
    final bytes = await img.readAsBytes();
    if (bytes.isEmpty) continue;

    final page = document.pages.add();
    final image = PdfBitmap(bytes);

    page.graphics.drawImage(
      image,
      Rect.fromLTWH(
        0,
        0,
        page.getClientSize().width,
        page.getClientSize().height,
      ),
    );
  }

  if (document.pages.count == 0) {
    document.pages.add().graphics.drawString(
      'No valid images found',
      PdfStandardFont(PdfFontFamily.helvetica, 18),
      bounds: const Rect.fromLTWH(0, 0, 500, 50),
    );
  }

  final tempDir = await getTemporaryDirectory();
  final filePath = '${tempDir.path}/scanned.pdf';
  final pdfFile = File(filePath);
  await pdfFile.writeAsBytes(await document.save());
  return pdfFile;
}
