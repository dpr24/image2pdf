import 'dart:typed_data';

import 'package:syncfusion_flutter_pdf/pdf.dart';

class PasswordProtector {
  static Future<Uint8List> setPasswordToPdf(
      {required Uint8List bytes, required String password}) async {
    PdfDocument doc = PdfDocument(inputBytes: bytes);
    PdfSecurity security = doc.security;

    security.userPassword = password;
    security.ownerPassword = password;

    security.algorithm = PdfEncryptionAlgorithm.aesx256Bit;

    final encryptedPdfBytes = doc.saveSync();

    doc.dispose();

    return Uint8List.fromList(encryptedPdfBytes);
  }
}
