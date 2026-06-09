import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../data/dummy_user.dart'; // Sesuaikan dengan lokasi file dummy_user.dart
import '../models/user_model.dart';
import '../widgets/logout_dialog.dart'; // Sesuaikan dengan lokasi LogoutDialog kamu
import 'notification_page.dart';
import 'privacy_policy_page.dart';
import 'edit_profile_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? profileImage;
  final ImagePicker picker = ImagePicker();
  late UserModel currentUserData;

  // Ambil data langsung dari objek currentUser di dummy_user.dart
  String userName = currentUser.name;
  String userUsername = currentUser.username;

  @override
  void initState() {
    super.initState();
    currentUserData = currentUser;
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source, imageQuality: 80);

    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
      });
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
                title: const Text("Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF8DBBE8),
      body: Stack(
        children: [
          /// BACKGROUND
          SizedBox(
            height: size.height * 0.38,
            width: double.infinity,
            child: Image.asset(
              'assets/images/profile/background_profile.png',
              fit: BoxFit.cover,
            ),
          ),

          /// CARD PUTIH
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.65,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 80),

                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    userUsername,
                    style: const TextStyle(color: Colors.grey, fontSize: 15),
                  ),

                  const SizedBox(height: 30),

                  /// EDIT PROFILE
                  buildMenuButton(
                    icon: Icons.person,
                    title: "Edit Profil",
                    onTap: () async {
                      // Kirim data currentUserData ke EditProfileScreen
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditProfileScreen(user: currentUserData),
                        ),
                      );

                      // Jika mendapatkan data balikan berupa UserModel yang baru
                      if (result != null && result is UserModel) {
                        setState(() {
                          currentUserData = result;
                          userName = result.name;
                          userUsername = result.username;
                        });
                      }
                    },
                  ),

                  const SizedBox(height: 14),

                  /// NOTIFIKASI
                  buildMenuButton(
                    icon: Icons.notifications,
                    title: "Notifikasi",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NotificationScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 14),

                  /// PRIVASI
                  buildMenuButton(
                    icon: Icons.lock,
                    title: "Kebijakan Privasi",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PrivacyPolicyScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 35),

                  /// LOGOUT
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            // Memanggil komponen LogoutDialog yang sudah kamu sediakan
                            return LogoutDialog(onLogout: () {});
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4D96E8),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout_rounded, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            "Keluar",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// AVATAR
          Positioned(
            top: size.height * 0.28,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: showImagePicker,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: profileImage != null
                            ? FileImage(profileImage!)
                            : const AssetImage(
                                    'assets/images/profile/avatar.png',
                                  )
                                  as ImageProvider,
                      ),
                    ),

                    // Overlay gelap transparan
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withValues(alpha: 0.25),
                      ),
                    ),

                    // Icon kamera di tengah
                    const Icon(Icons.camera_alt, color: Colors.white, size: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 58,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF4D96E8)),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF4D96E8), size: 22),
            const SizedBox(width: 14),
            Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}