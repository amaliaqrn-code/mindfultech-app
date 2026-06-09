import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindfultech_app/data/datasources/auth_local_datasource.dart';
import 'package:mindfultech_app/data/datasources/profile_remote_datasource.dart';
import 'package:mindfultech_app/data/repositories/profile_repository.dart';
import 'package:mindfultech_app/data/models/user_model.dart';
import 'package:mindfultech_app/core/network/dio_client.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileBloc({ProfileRepository? profileRepository})
      : _profileRepository = profileRepository ??
            ProfileRepository(
              remoteDataSource: ProfileRemoteDataSource(DioClient()),
              localDataSource: AuthLocalDataSource(),
            ),
        super(const ProfileState.initial()) {

    // Handler saat BLoC pertama kali aktif
    on<_Started>((event, emit) async {
      emit(const ProfileState.loading());
 try {
        // Coba ambil dari local storage dulu (cache)
        final localUser = _profileRepository.getLocalUser();
        if (localUser != null) {
          emit(ProfileState.success(user: localUser));
        } else {
          // Jika tidak ada di local, emit dummy user
          emit(ProfileState.success(user: _createDefaultUser()));
        }
      } catch (e) {
        emit(ProfileState.success(user: _createDefaultUser()));
      }
    });

    // Handler untuk update text profil
    on<_UpdateProfile>((event, emit) async {
      final currentState = state;
      if (currentState is _Success) {
        emit(const ProfileState.loading());

        try {
          // Kirim ke server Laravel
          final updatedUser = await _profileRepository.updateProfile(
            name: event.updatedUser.name,
            username: event.updatedUser.username,
            phone: event.updatedUser.phone,
            gender: event.updatedUser.gender,
          );

          // Emit sukses dengan data dari server
          emit(ProfileState.success(
            user: updatedUser,
            profileImage: currentState.profileImage,
          ));
        } catch (e) {
          // Jika gagal, tetap update lokal tapi tampilkan error
          emit(ProfileState.success(
            user: event.updatedUser,
            profileImage: currentState.profileImage,
          ));
          // Emit error message
          emit(ProfileState.error(message: e.toString()));
          // Kembali ke state success
          emit(ProfileState.success(
            user: event.updatedUser,
            profileImage: currentState.profileImage,
          ));
        }
      }
    });

    // Handler untuk update foto profil
    on<_UpdateProfileImage>((event, emit) async {
      final currentState = state;
      if (currentState is _Success) {
        emit(const ProfileState.loading());

        try {
          // Upload foto ke server
          await _profileRepository.uploadProfilePhoto(event.imageFile);

          emit(ProfileState.success(
            user: currentState.user,
            profileImage: event.imageFile,
          ));
        } catch (e) {
          // Jika gagal upload, tetap tampilkan foto lokal
          emit(ProfileState.success(
            user: currentState.user,
            profileImage: event.imageFile,
          ));
          emit(ProfileState.error(message: 'Gagal upload foto: ${e.toString()}'));
          emit(ProfileState.success(
            user: currentState.user,
            profileImage: event.imageFile,
          ));
        }
      }
    });
  }

  /// Buat default user untuk fallback
  UserModel _createDefaultUser() {
    return UserModel(
      id: 0,
      name: 'User',
      username: '@user',
      gender: '',
      phone: '',
      email: '',
    );
  }
}
