import 'package:flutter/material.dart';
import '../models/user_model.dart'; // Pastikan import model user sesuai path proyekmu

class EditProfileScreen extends StatefulWidget {
  final UserModel user; // Tambahkan parameter untuk menerima data user

  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool obscurePassword = true;

  // Inisialisasi controller menggunakan data dari widget.user
  late final TextEditingController nameController;
  late final TextEditingController usernameController;
  late final TextEditingController genderController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    usernameController = TextEditingController(text: widget.user.username);
    genderController = TextEditingController(text: widget.user.gender);
    phoneController = TextEditingController(text: widget.user.phone);
    emailController = TextEditingController(text: widget.user.email);
    passwordController = TextEditingController(text: "12345678"); // Default password placeholder
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
    return Scaffold(
      body: Stack(
        children: [
          /// Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/profile/background_profile.png',
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                /// Header
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const CircleAvatar(
                          radius: 14,
                          backgroundColor: Color(0xff5AA9FF),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      const Spacer(),

                      const Text(
                        "Edit Profil",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff5AA9FF),
                        ),
                      ),

                      const Spacer(),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          _buildField("Name", nameController),

                          const SizedBox(height: 16),

                          _buildField("Username", usernameController),

                          const SizedBox(height: 16),

                          _buildField("Gender", genderController),

                          const SizedBox(height: 16),

                          _buildField("Phone Number", phoneController),

                          const SizedBox(height: 16),

                          _buildField("Email", emailController),

                          const SizedBox(height: 16),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Password",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          TextField(
                            controller: passwordController,
                            obscureText: obscurePassword,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    obscurePassword = !obscurePassword;
                                  });
                                },
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xff5AA9FF),
                                    Color(0xff76E1C3),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Kembalikan objek UserModel yang sudah diperbarui nilainya
                                  Navigator.pop(
                                    context,
                                    UserModel(
                                      id: widget.user.id,
                                      name: nameController.text,
                                      username: usernameController.text,
                                      gender: genderController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                ),
                                child: const Text(
                                  "Simpan",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
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
        ],
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade800,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 8),

        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
      ],
    );
  }
}