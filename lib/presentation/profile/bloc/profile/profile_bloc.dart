import 'dart:io';

import 'package:flutter/material.dart';
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
    : _profileRepository =
          profileRepository ??
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

    // Handler untuk update foto profil
    on<_UpdateProfile>((event, emit) async {
      debugPrint("=== MASUK UPDATE PROFILE ===");

      final currentState = state;

      debugPrint("STATE SEKARANG: $currentState");

      if (currentState is _Success) {
        debugPrint("STATE SUCCESS");

        emit(const ProfileState.loading());

        try {
          debugPrint("SEBELUM CALL REPOSITORY");

          final updatedUser = await _profileRepository.updateProfile(
            name: event.updatedUser.name,
            username: event.updatedUser.username,
            phone: event.updatedUser.phone,
            gender: event.updatedUser.gender,
          );

          debugPrint("SESUDAH CALL REPOSITORY");

          debugPrint("===== UPDATE SUCCESS =====");
          debugPrint("NAME: ${updatedUser.name}");
          debugPrint("USERNAME: ${updatedUser.username}");
          debugPrint("PHONE: ${updatedUser.phone}");
          debugPrint("GENDER: ${updatedUser.gender}");
          debugPrint("==========================");

          emit(
            ProfileState.success(
              user: updatedUser,
              profileImage: currentState.profileImage,
            ),
          );
        } catch (e) {
          debugPrint("ERROR UPDATE: $e");

          emit(ProfileState.error(message: e.toString()));
        }
      } else {
        debugPrint("STATE BUKAN SUCCESS");
      }
    });

    // Handler untuk upload foto profil
    on<_UpdateProfileImage>((event, emit) async {
      final currentState = state;
      if (currentState is _Success) {
        emit(const ProfileState.loading());
        try {
          final photoUrl = await _profileRepository.uploadProfilePhoto(
            event.imageFile,
          );

          final updatedUser = UserModel(
            id: currentState.user.id,
            name: currentState.user.name,
            email: currentState.user.email,
            username: currentState.user.username,
            gender: currentState.user.gender,
            phone: currentState.user.phone,
            imagePath: photoUrl,
            createdAt: currentState.user.createdAt,
          );

          emit(
            ProfileState.success(
              user: updatedUser,
              profileImage: event.imageFile,
            ),
          );
        } catch (e) {
          emit(ProfileState.error(message: e.toString()));
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
