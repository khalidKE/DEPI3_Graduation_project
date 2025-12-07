import 'dart:io';

import 'package:books/core/base/view_state.dart';

class ProfileState {
  final ViewStatus status;
  final File? image;
  final String? message;

  const ProfileState({
    this.status = ViewStatus.idle,
    this.image,
    this.message,
  });

  bool get isLoading => status == ViewStatus.loading;
  bool get hasImage => image != null;

  ProfileState copyWith({
    ViewStatus? status,
    File? image,
    String? message,
  }) {
    return ProfileState(
      status: status ?? this.status,
      image: image ?? this.image,
      message: message ?? this.message,
    );
  }
}
