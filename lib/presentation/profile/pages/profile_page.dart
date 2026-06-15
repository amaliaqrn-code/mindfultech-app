// profile_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindfultech_app/presentation/profile/bloc/profile/profile_bloc.dart';
import 'package:mindfultech_app/data/models/user_model.dart';
import '../widgets/logout_dialog.dart';
import 'notification_page.dart';
import 'privacy_policy_page.dart';
import 'edit_profile_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const ProfileEvent.started());
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source, imageQuality: 80);
    if (pickedFile != null) {
      if (mounted) {
        context.read<ProfileBloc>().add(
          ProfileEvent.updateProfileImage(imageFile: File(pickedFile.path)),
        );
      }
    }
  }

  void showImagePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galeri'),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Kamera'),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Tentukan warna utama aplikasi
    const primaryColor = Color(0xFF4D96E8);

    return Scaffold(
      // 1. Menggunakan Stack untuk latar belakang gambar awan
      body: Stack(
        children: [
          // Latar Belakang Gambar Awan
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                // Pastikan gambar ini ada di folder assets dan terdaftar di pubspec.yaml
                image: AssetImage(
                  'assets/images/profile/background_profile.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Konten Utama
          SafeArea(
            child: BlocConsumer<ProfileBloc, ProfileState>(
              listener: (context, state) {
                state.maybeWhen(
                  error: (message) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                  orElse: () {},
                );
              },
              builder: (context, state) {
                final UserModel user = state.maybeWhen(
                  success: (user, _) => user,
                  orElse: () => UserModel(
                    id: 0,
                    name: '',
                    username: '',
                    gender: '',
                    phone: '',
                    email: '',
                  ),
                );
                final localImage = state.maybeWhen(
                  success: (_, image) => image,
                  orElse: () => null,
                );

                return Column(
                  children: [
                    // Header (Judul "Profil")
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 36,
                          ), // Spacer untuk keseimbangan
                          const Expanded(
                            child: Text(
                              "Profil",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 150),

                    // Foto Profil dengan Stack untuk Ikon Kamera
                    Transform.translate(offset: Offset(0, 20)),
                    Center(
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: showImagePicker,
                            child: CircleAvatar(
                              radius: 55,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.grey.shade200,
                                backgroundImage: localImage != null
                                    ? FileImage(localImage)
                                    : (user.imagePath != null &&
                                                  user.imagePath!.isNotEmpty
                                              ? NetworkImage(user.imagePath!)
                                              : const AssetImage(
                                                  'assets/images/profile/avatar.png',
                                                ))
                                          as ImageProvider,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 5,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: primaryColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 2. Container Putih Melengkung untuk Area Konten Bawah
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30),
                          ),
                        ),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Nama dan Username
                              Text(
                                user.name.isNotEmpty ? user.name : 'Pengguna',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                user.username?.isNotEmpty == true
                                    ? '@${user.username}'
                                    : '@belum_diatur',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),

                              const SizedBox(height: 70),

                              // Tombol Menu
                              _buildMenuButton(
                                icon: Icons.person_outline,
                                title: "Ubah Profil",
                                color: primaryColor,
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        EditProfileScreen(user: user),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              _buildMenuButton(
                                icon: Icons.notifications_none,
                                title: "Notifikasi",
                                color: primaryColor,
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const NotificationScreen(),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              _buildMenuButton(
                                icon: Icons.privacy_tip_outlined,
                                title: "Kebijakan Privasi",
                                color: primaryColor,
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const PrivacyPolicyScreen(),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 40),

                              // Tombol Keluar
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton.icon(
                                  onPressed: () => showDialog(
                                    context: context,
                                    builder: (_) =>
                                        LogoutDialog(onLogout: () {}),
                                  ),
                                  icon: const Icon(
                                    Icons.logout,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  label: const Text(
                                    "Keluar",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    elevation: 0,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }



  // Widget Pembantu untuk Tombol Menu
  Widget _buildMenuButton({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 58,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          border: Border.all(color: color.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(14),
          color: color.withValues(alpha: 0.05),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 14),
            Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
