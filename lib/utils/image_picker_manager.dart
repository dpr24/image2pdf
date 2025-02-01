import 'package:image_picker/image_picker.dart';

class ImagePickerManager {
  static final ImagePicker _picker = ImagePicker();

  // Function to pick multiple images from gallery
  static Future<List<XFile>> pickMultipleImages() async {
    // Pick multiple images from gallery
    final List<XFile> pickedFiles =
        await _picker.pickMultiImage(imageQuality: 10);

    if (pickedFiles.isNotEmpty) {
      return pickedFiles;
    } else {
      return [];
    }
  }

  static Future<XFile?> pickImage() async {
    // Pick multiple images from gallery
    return await _picker.pickImage(
        source: ImageSource.gallery, imageQuality: 10);
  }
}
