import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ProfileRepository {
  ProfileRepository({ImagePicker? picker})
      : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  Future<File?> pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return null;
    return File(picked.path);
  }
}
