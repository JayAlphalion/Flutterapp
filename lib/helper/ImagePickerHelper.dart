import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  Future<File> getImageFromCamera() async {
    ImagePicker _picker = ImagePicker();
    PickedFile? file = await _picker.getImage(source: ImageSource.camera);
    return File(file!.path);
  }

  Future<File> getImageFromGallery() async {
    ImagePicker _picker = ImagePicker();
    PickedFile? file = await _picker.getImage(source: ImageSource.gallery);
    return File(file!.path);
  }
}
