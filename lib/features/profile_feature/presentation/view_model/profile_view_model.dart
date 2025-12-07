import 'package:books/core/base/view_state.dart';
import 'package:books/features/profile_feature/data/profile_repository.dart';
import 'package:books/features/profile_feature/presentation/view_model/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileViewModel extends Cubit<ProfileState> {
  ProfileViewModel({ProfileRepository? repository})
      : _repository = repository ?? ProfileRepository(),
        super(const ProfileState());

  final ProfileRepository _repository;

  Future<void> pickImage() async {
    emit(state.copyWith(status: ViewStatus.loading, message: null));
    try {
      final image = await _repository.pickImage();
      if (image != null) {
        emit(
          state.copyWith(
            status: ViewStatus.success,
            image: image,
            message: null,
          ),
        );
      } else {
        emit(state.copyWith(status: ViewStatus.idle));
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: ViewStatus.failure,
          message: 'Error picking image: $e',
        ),
      );
    }
  }
}
