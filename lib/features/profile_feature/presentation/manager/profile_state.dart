import 'dart:io';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileImageChanged extends ProfileState {
  final File image;
  ProfileImageChanged(this.image);
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}