part of 'pdf_bloc.dart';

// @immutable
sealed class PdfEvent {}

class SavePdf extends PdfEvent {
  final String password;

  final Uint8List pdfBytes;

  SavePdf({required this.password, required this.pdfBytes});
}
