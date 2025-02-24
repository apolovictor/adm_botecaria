import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../asp/actions.dart';

Future<void> getGalleryImage(double maxWidth, double maxHeight) async {
  if (kIsWeb) {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      Uint8List fileBytes = result.files.first.bytes!;

      setProductImageAction(fileBytes);
    }
  } else {
    final ImagePicker picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
    );
    if (pickedFile != null) {
      final fileBytes = await pickedFile.readAsBytes();

      setProductImageAction(fileBytes);
    }
  }
}
