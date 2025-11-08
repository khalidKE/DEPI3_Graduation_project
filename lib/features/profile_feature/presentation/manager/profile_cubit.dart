import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  File? image;

  Future<void> pickImage() async {
    try {
      final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picked != null) {
        image = File(picked.path);
        emit(ProfileImageChanged(image!));
      }
    } catch (e) {
      emit(ProfileError("Error picking image: $e"));
    }
  }
}
