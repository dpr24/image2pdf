import 'dart:typed_data';

import 'package:image2pdf/screens/home/model/pdf_data.dart';
import 'package:image2pdf/security/password_protector.dart';
import 'package:image2pdf/utils/pdf/save_encrypted_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfGenerator {
  static Future<Uint8List> generatePdf({required PdfData data}) async {
    final doc = Document();

    print('images len from generatePdf : ${data.images.length}');

    pw.MemoryImage? overlayImg;
    if (data.overlayImage != null) {
      final imageBytes = await data.overlayImage!.readAsBytes();
      overlayImg = pw.MemoryImage(imageBytes);
    }

    for (var img in data.images) {
      // Read bytes from XFile
      final imageBytes = await img.readAsBytes();

      // Convert bytes to a MemoryImage
      final pdfImage = pw.MemoryImage(imageBytes);

      // Add the image to the PDF
      doc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Stack(children: [
              pw.Expanded(child: pw.Center(child: pw.Image(pdfImage))),
              if (data.overlayImage != null) ...[
                pw.Expanded(
                    child: pw.Opacity(
                        opacity: 0.1,
                        child: pw.Image(
                          overlayImg!,
                          fit: pw.BoxFit.cover,
                        )))
              ],
              pw.Align(
                  alignment: pw.Alignment.bottomCenter,
                  child: pw.Text('Page ${data.images.indexOf(img) + 1}'))
            ]);
          },
        ),
      );
    }

    return await doc.save();
  }

  static Future<Uint8List> encryptPdf(Map<String, dynamic> args) {
    return PasswordProtector.setPasswordToPdf(
        bytes: args['bytes'], password: args['password']);
  }

  static Future<int> savePdf(Uint8List encryptedBytes) {
    return SaveEncryptedFile.saveEncryptedPdf(encryptedBytes);
  }
}
