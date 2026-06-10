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
  // Controller form teks
  late final TextEditingController nameController;
  late final TextEditingController usernameController;
  late final TextEditingController genderController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    // Mengisi data bawaan pendaftaran awal secara otomatis
    nameController = TextEditingController(text: widget.user.name);
    usernameController = TextEditingController(text: widget.user.username);
    genderController = TextEditingController(text: widget.user.gender);
    phoneController = TextEditingController(text: widget.user.phone);
    emailController = TextEditingController(text: widget.user.email);
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    genderController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF6FF),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          state.maybeWhen(
            loading: () {
              // Munculkan loading indicator saat saving ke server & local database
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const Center(child: CircularProgressIndicator()),
              );
            },
            success: (user, _) {
              Navigator.pop(context); // Tutup loading dialog
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profil berhasil diperbarui!'), backgroundColor: Colors.green),
              );
              Navigator.pop(context); // Kembali ke halaman ProfileScreen utama
            },
            error: (message) {
              Navigator.pop(context); // Tutup loading dialog
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), backgroundColor: Colors.red),
              );
            },
            orElse: () {},
          );
        },
        child: SafeArea(
          child: Column(
            children: [
              // HEADER BAR
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                        child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        "Ubah Profil",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 36), // Seimbang kanan kiri
                  ],
                ),
              ),

              // FORM FIELDS CONTAINER
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        _buildField("Nama Lengkap", nameController, placeholder: "Masukkan nama"),
                        const SizedBox(height: 20),
                        _buildField("Username", usernameController, placeholder: "Contoh: budi_santo"),
                        const SizedBox(height: 20),
                        _buildField("Jenis Kelamin", genderController, placeholder: "Male / Female"),
                        const SizedBox(height: 20),
                        _buildField("Nomor Telepon", phoneController, placeholder: "Contoh: 0812XXXXXXXX"),
                        const SizedBox(height: 20),
                        
                        // Kolom Email dikunci (Read-Only) demi integritas data akun auth laravel
                        _buildField("Email", emailController, isReadOnly: true),
                        
                        const SizedBox(height: 40),

                        // BUTTON ACTION SIMPAN
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF4A90E2), Color(0xFF78E6C8)],
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                // 1. Susun objek user baru dari isian input form teks
                                final updatedUser = UserModel(
                                  id: widget.user.id,
                                  name: nameController.text.trim(),
                                  username: usernameController.text.trim(),
                                  gender: genderController.text.trim(),
                                  phone: phoneController.text.trim(),
                                  email: widget.user.email,
                                );

                                // 2. Trigger Event BLoC untuk save otomatis ke Laravel + Local Database
                                context.read<ProfileBloc>().add(
                                      ProfileEvent.updateProfile(updatedUser: updatedUser),
                                    );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              ),
                              child: const Text(
                                "Simpan",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    String label, 
    TextEditingController controller, {
    String placeholder = "", 
    bool isReadOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade800, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          readOnly: isReadOnly,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            filled: true,
            fillColor: isReadOnly ? Colors.grey.shade100 : Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFF4A90E2), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}