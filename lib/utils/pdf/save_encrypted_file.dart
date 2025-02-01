import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image2pdf/screens/home/bloc/home_bloc.dart';
import 'package:path_provider/path_provider.dart';

class SaveEncryptedFile {
  static Future<int> saveEncryptedPdf(Uint8List encryptedBytes) async {
    final bloc = Get.context!.read<HomeBloc>();

    final s = bloc.state as HomeInitial;

    try {
      // Use File Picker to pick a location using SAF (Storage Access Framework)
      var result = await FilePicker.platform.saveFile(
          dialogTitle: 'Save PDF',
          fileName: 'encrypted_pdf.pdf',
          allowedExtensions: ['pdf'],
          bytes: encryptedBytes);

      if (result != null) {
        final dir = await getApplicationCacheDirectory();
        dir.delete();
        return 1;
      } else {
        print('File save operation was cancelled');
        return 0;
      }
    } on PlatformException catch (e) {
      print('Error saving file: $e');
      return 0;
    }
  }
}
