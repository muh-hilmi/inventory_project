import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerHandler {
  final ImagePicker _picker = ImagePicker();
  XFile? pickedImage;

  Future<File?> getImageFromGallery() async {
    try {
      final checkImage = await _picker.pickImage(source: ImageSource.gallery);

      if (checkImage != null) {
        pickedImage = checkImage;
        return File(pickedImage!.path);
      }

      return null;
    } catch (e) {
      print(e.toString());
      pickedImage = null;
      return null;
    }
  }
}
