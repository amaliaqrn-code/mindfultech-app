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
    // 📢 Ambil data profile terbaru saat halaman dibuka
    context.read<ProfileBloc>().add(const ProfileEvent.started());
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source, imageQuality: 80);

    if (pickedFile != null) {
      if (mounted) {
        // 📢 Kirim foto ke server dan lokal via BLoC
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          state.maybeWhen(
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), backgroundColor: Colors.red),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          // Ambil data user dari state BLoC jika sukses, jika tidak gunakan default kosongan
          final UserModel user = state.maybeWhen(
            success: (user, _) => user as UserModel,
            orElse: () => UserModel(
              id: 0,
              name: 'Loading...',
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

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    "Profil",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),

                  // Avatar Lingkaran Foto Profil
                  Center(
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: showImagePicker,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF4D96E8),
                                width: 3,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 55,
                              backgroundColor: Colors.grey.shade200,
                              backgroundImage: localImage != null
                                  ? FileImage(localImage)
                                  : (user.imagePath != null && user.imagePath!.isNotEmpty
                                      ? NetworkImage(user.imagePath!)
                                      : const AssetImage('assets/images/default_avatar.png')) as ImageProvider,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 4,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: const Color(0xFF4D96E8),
                            child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Tampilkan Nama Asli hasil pendaftaran/update
                  Text(
                    user.name,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  
                  // Tampilkan @username (akan kosong jika belum diisi)
                  Text(
                    user.username?.isNotEmpty == true ? '@${user.username}' : '@belum_diatur',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),

                  const SizedBox(height: 40),

                  // MENU LIST BUTTONS
                  buildMenuButton(
                    icon: Icons.person_outline,
                    title: "Ubah Profil",
                    onTap: () {
                      // Kunci utama: Melempar data user saat ini ke halaman edit
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditProfileScreen(user: user),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  buildMenuButton(
                    icon: Icons.notifications_none,
                    title: "Notifikasi",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const NotificationScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  buildMenuButton(
                    icon: Icons.privacy_tip_outlined,
                    title: "Kebijakan Privasi",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 40),

                  // Tombol Keluar Log Out
                  TextButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => LogoutDialog(onLogout: () {}),
                      );
                    },
                    icon: const Icon(Icons.logout, color: Colors.red),
                    label: const Text(
                      "Keluar Akun",
                      style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildMenuButton({
    required IconData icon,
    required String title,
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
          border: Border.all(color: const Color(0xFF4D96E8).withOpacity(0.3)),
          borderRadius: BorderRadius.circular(14),
          color: const Color(0xFFF4F9FF),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF4D96E8), size: 22),
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