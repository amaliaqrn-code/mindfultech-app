import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindfultech_app/presentation/profile/bloc/profile/profile_bloc.dart';
import 'package:mindfultech_app/data/models/user_model.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;

  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _isSaving = false;

  late final TextEditingController nameController;
  late final TextEditingController usernameController;
  late final TextEditingController genderController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  bool _isPasswordObscured = true;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    usernameController = TextEditingController(text: widget.user.username);
    genderController = TextEditingController(text: widget.user.gender);
    phoneController = TextEditingController(text: widget.user.phone);
    emailController = TextEditingController(text: widget.user.email);
    passwordController = TextEditingController(text: "•••••");
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    genderController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const borderColor = Color(0xFF4A90E2);

    return Scaffold(
      // Menggunakan resizeToAvoidBottomInset agar keyboard tidak merusak tataletak background
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // 1. Latar Belakang Gambar Awan Penuh
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/profile/background_profile.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Konten Utama menggunakan LayoutBuilder / CustomScrollView untuk menghindari layout error
          SafeArea(
            child: BlocListener<ProfileBloc, ProfileState>(
              listener: (context, state) {
                state.maybeWhen(
                  loading: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) =>
                          const Center(child: CircularProgressIndicator()),
                    );
                  },
                  success: (user, _) {
                    if (mounted) {
                      setState(() {
                        _isSaving = false;
                      });
                    }
                    debugPrint("SUCCESS PROFILE UPDATE");

                    if (Navigator.of(context, rootNavigator: true).canPop()) {
                      Navigator.of(context, rootNavigator: true).pop();
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Profil berhasil diperbarui!'),
                        backgroundColor: Colors.green,
                      ),
                    );

                    Future.delayed(const Duration(milliseconds: 300), () {
                      if (mounted) {
                        Navigator.pop(context, true);
                      }
                    });
                  },
                  error: (message) {
                    if (mounted) {
                      setState(() {
                        _isSaving = false;
                      });
                    }
                    if (Navigator.of(context, rootNavigator: true).canPop()) {
                      Navigator.of(context, rootNavigator: true).pop();
                    }

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
              child: Column(
                children: [
                  // HEADER BAR
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: const BoxDecoration(
                              color: Color(0xFF4A90E2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            "Edit Profil",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF59B2CD),
                            ),
                          ),
                        ),
                        const SizedBox(width: 36),
                      ],
                    ),
                  ),

                  // KONTEN FORM DI DALAM VIEWPORT AMAN
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shrinkWrap: true,
                      children: [
                        // Card Putih Tengah Kotak
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Column(
                            children: [
                              _buildField(
                                "Name",
                                nameController,
                                borderColor: borderColor,
                              ),
                              const SizedBox(height: 16),
                              _buildField(
                                "Username",
                                usernameController,
                                borderColor: borderColor,
                              ),
                              const SizedBox(height: 16),
                              _buildField(
                                "Gender",
                                genderController,
                                borderColor: borderColor,
                              ),
                              const SizedBox(height: 16),
                              _buildField(
                                "Phone Number",
                                phoneController,
                                borderColor: borderColor,
                              ),
                              const SizedBox(height: 16),
                              _buildField(
                                "Email",
                                emailController,
                                isReadOnly: true,
                                borderColor: borderColor,
                              ),
                              const SizedBox(height: 16),
                              _buildField(
                                "Password",
                                passwordController,
                                borderColor: borderColor,
                                isPassword: true,
                                isObscured: _isPasswordObscured,
                                onToggleVisibility: () {
                                  setState(() {
                                    _isPasswordObscured = !_isPasswordObscured;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Tombol Simpan Gradasi Oval (Capsule Style)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            width: double.infinity,
                            height: 54,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF4A90E2), Color(0xFF78E6C8)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: _isSaving
                                  ? null
                                  : () {
                                      setState(() {
                                        _isSaving = true;
                                      });

                                      debugPrint("TOMBOL SIMPAN DIKLIK");

                                      final updatedUser = UserModel(
                                        id: widget.user.id,
                                        name: nameController.text.trim(),
                                        username: usernameController.text
                                            .trim(),
                                        gender: genderController.text.trim(),
                                        phone: phoneController.text.trim(),
                                        email: widget.user.email,
                                      );

                                      context.read<ProfileBloc>().add(
                                        ProfileEvent.updateProfile(
                                          updatedUser: updatedUser,
                                        ),
                                      );
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text(
                                "Simpan",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ), // Ruang ekstra agar tidak mentok navigasi bawah saat di-scroll
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller, {
    bool isReadOnly = false,
    required Color borderColor,
    bool isPassword = false,
    bool isObscured = false,
    VoidCallback? onToggleVisibility,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          readOnly: isReadOnly,
          obscureText: isPassword ? isObscured : false,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            filled: true,
            fillColor: isReadOnly ? Colors.grey.shade50 : Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      isObscured
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: const Color(0xFF4A90E2),
                    ),
                    onPressed: onToggleVisibility,
                  )
                : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: borderColor.withValues(alpha: 0.6),
                width: 1.2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: borderColor, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
