import 'dart:io';

import 'package:mindfultech_app/data/datasources/auth_local_datasource.dart';
import 'package:mindfultech_app/data/datasources/profile_remote_datasource.dart';
import 'package:mindfultech_app/data/models/user_model.dart';

/// Repository untuk Profile
/// Mengikuti pola yang sama dengan AuthRepository
class ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  ProfileRepository({
    required ProfileRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  /// Update profile user di server dan simpan ke local storage
  Future<UserModel> updateProfile({
    String? name,
    String? username,
    String? phone,
    String? gender,
  }) async {
    try {
      // Panggil API untuk update profile
      final updatedUser = await _remoteDataSource.updateProfile(
        name: name,
        username: username,
        phone: phone,
        gender: gender,
      );

      // Simpan user yang sudah diupdate ke local storage
      await _localDataSource.saveUser(updatedUser);

      return updatedUser;
    } catch (e) {
      // Re-throw dengan pesan clean
      String message = e.toString();
      if (message.startsWith('Exception: ')) {
        message = message.replaceFirst('Exception: ', '');
      }
      throw Exception(message);
    }
  }

  /// Ambil profile user dari server
  Future<UserModel> getProfile() async {
    try {
      final user = await _remoteDataSource.getProfile();

      // Simpan ke local storage untuk caching
      await _localDataSource.saveUser(user);

      return user;
    } catch (e) {
      // Jika gagal ambil dari server, coba dari local
      final localUser = _localDataSource.getUser();
      if (localUser != null) {
        return localUser;
      }

      String message = e.toString();
      if (message.startsWith('Exception: ')) {
        message = message.replaceFirst('Exception: ', '');
      }
      throw Exception(message);
    }
  }

  /// Upload foto profile
  Future<String> uploadProfilePhoto(File imageFile) async {
    try {
      final photoUrl = await _remoteDataSource.uploadProfilePhoto(imageFile);

      // Update local user dengan photo_url baru
      final currentUser = _localDataSource.getUser();
      if (currentUser != null) {
        final updatedUser = UserModel(
          id: currentUser.id,
          name: currentUser.name,
          email: currentUser.email,
          username: currentUser.username,
          gender: currentUser.gender,
          phone: currentUser.phone,
          imagePath: photoUrl,
          createdAt: currentUser.createdAt,
        );
        await _localDataSource.saveUser(updatedUser);
      }

      return photoUrl;
    } catch (e) {
      String message = e.toString();
      if (message.startsWith('Exception: ')) {
        message = message.replaceFirst('Exception: ', '');
      }
      throw Exception(message);
    }
  }

  /// Ambil user dari local storage (cache)
  UserModel? getLocalUser() {
    return _localDataSource.getUser();
  }

  /// Cek apakah user sudah login
  bool isLoggedIn() {
    return _localDataSource.isLoggedIn();
  }
}