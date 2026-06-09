part of 'profile_bloc.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.started() = _Started;
  
  // Event saat user menekan tombol simpan setelah edit teks profil
  const factory ProfileEvent.updateProfile({
    required UserModel updatedUser,
  }) = _UpdateProfile;

  // Event saat user berhasil memilih foto baru dari Gallery/Camera
  const factory ProfileEvent.updateProfileImage({
    required File imageFile,
  }) = _UpdateProfileImage;
}