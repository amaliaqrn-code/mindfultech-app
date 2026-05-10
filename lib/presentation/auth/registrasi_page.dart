import 'package:flutter/material.dart';
import 'login_page.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({super.key});

  @override
  State<RegistrasiPage> createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _agreeTerms = false;
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [

                  const SizedBox(height: 20),

                  // 🌟 IMAGE
                  Image.asset(
                    'assets/images/mindy_regist.png',
                    height: 100,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.cloud, size: 80, color: Colors.grey),
                  ),

                  const SizedBox(height: 24),

                  // 🌈 TITLE
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        Color(0xFF4597E6),
                        Color(0xFF7BBEFF),
                        Color(0xFF83DFC6),
                      ],
                    ).createShader(bounds),
                    child: const Text(
                      'Buat Akun',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Teman fokus yang siap menemani harimu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF655F5F),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // INPUT
                  _buildTextField(
                    controller: _nameController,
                    label: 'Nama',
                    assetIcon: 'assets/images/profile.png',
                    validator: (v) => v!.isEmpty ? 'Nama harus diisi' : null,
                  ),

                  const SizedBox(height: 18),

                  _buildTextField(
                    controller: _emailController,
                    label: 'Email',
                    assetIcon: 'assets/images/email.png',
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      if (v!.isEmpty) return 'Email harus diisi';
                      if (!v.contains('@')) return 'Email tidak valid';
                      return null;
                    },
                  ),

                  const SizedBox(height: 18),

                  _buildPasswordField(
                    controller: _passwordController,
                    label: 'Kata Sandi',
                    obscureText: _obscurePassword,
                    onToggle: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                    assetLock: 'assets/images/lock.png',
                    assetEye: 'assets/images/eye.png',
                    validator: (v) =>
                        v!.length < 6 ? 'Minimal 6 karakter' : null,
                  ),

                  const SizedBox(height: 18),

                  _buildPasswordField(
                    controller: _confirmPasswordController,
                    label: 'Konfirmasi Kata Sandi',
                    obscureText: _obscureConfirmPassword,
                    onToggle: () {
                      setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
                    },
                    assetLock: 'assets/images/lock.png',
                    assetEye: 'assets/images/eye.png',
                    validator: (v) {
                      if (v != _passwordController.text) {
                        return 'Kata sandi tidak cocok';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 24),

                  // CHECKBOX
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() => _agreeTerms = !_agreeTerms);
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: _agreeTerms
                              ? const Icon(Icons.check, size: 14)
                              : null,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Saya setuju dengan syarat dan ketentuan',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // BUTTON DAFTAR
                  GestureDetector(
                    onTap: _handleRegister,
                    child: Container(
                      width: double.infinity,
                      height: 52,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF4597E6),
                            Color(0xFF7BBEFF),
                            Color(0xFF83DFC6),
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: const Center(
                        child: Text(
                          'Daftar',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 🔥 LOGIN NAVIGASI (INI YANG PENTING)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Sudah punya akun? '),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Masuk',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4597E6),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ================= FUNCTIONS =================

  void _handleRegister() {
    if (_formKey.currentState!.validate() && _agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pendaftaran berhasil!')),
      );
    } else if (!_agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap setujui syarat dan ketentuan')),
      );
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String assetIcon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: Image.asset(assetIcon, width: 20),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    required VoidCallback onToggle,
    required String assetLock,
    required String assetEye,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: Image.asset(assetLock, width: 20),
        ),
        suffixIcon: IconButton(
          icon: Image.asset(assetEye, width: 20),
          onPressed: onToggle,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}