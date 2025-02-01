part of 'pdf_bloc.dart';

// @immutable
sealed class PdfState {}

final class PdfInitial extends PdfState {}

class SettingPasswordToFile extends PdfState {
  final Uint8List pdfBytes;
  final String password;

  SettingPasswordToFile(this.pdfBytes, this.password);
}

class PdfSaved extends PdfState {
  final int res;
  PdfSaved(this.res);
}
