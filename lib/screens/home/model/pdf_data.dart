import 'package:image_picker/image_picker.dart';

class PdfData {
  final List<XFile> images;
  String? password;
  XFile? overlayImage;
  PdfData({
    required this.images,
    this.password,
    this.overlayImage,
  });

  PdfData copyWith({
    List<XFile>? images,
    String? password,
    XFile? overlay,
    bool setPasswordNull = false,
    bool setOverlayNull = false,
  }) {
    return PdfData(
        images: images ?? this.images,
        password: setPasswordNull ? null : (password ?? this.password),
        overlayImage: setOverlayNull ? null : (overlay ?? overlayImage));
  }
}
