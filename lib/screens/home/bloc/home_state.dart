part of 'home_bloc.dart';

// @immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {
  final bool isProcessing;
  final List<XFile> pickedImages;
  bool isMinimized;
  PdfData? pdfData;
  bool isLoadingImages;

  HomeInitial(
      {this.isProcessing = false,
      this.pickedImages = const [],
      this.isMinimized = true,
      this.isLoadingImages = false,
      this.pdfData});

  HomeInitial copyWith(
      {bool? isProcessing,
      List<XFile>? pickedImages,
      bool? isMinimized,
      PdfData? pdfdata,
      bool? isLoadingImages}) {
    return HomeInitial(
        isProcessing: isProcessing ?? this.isProcessing,
        pickedImages: pickedImages ?? List.from(this.pickedImages),
        isMinimized: isMinimized ?? this.isMinimized,
        pdfData: pdfdata ?? pdfData,
        isLoadingImages: isLoadingImages ?? this.isLoadingImages);
  }
}

class NavigateToPdfScreen extends HomeState {
  final Uint8List pdfBytes;
  final String password;

  NavigateToPdfScreen(this.pdfBytes, this.password);
}
