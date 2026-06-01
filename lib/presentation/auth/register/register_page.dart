import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/presentation/auth/bloc/register/register_bloc.dart';
import 'package:mindfultech_app/presentation/auth/bloc/register/register_event.dart';
import 'package:mindfultech_app/presentation/auth/bloc/register/register_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _agreeTerms = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          // Save user name to storage
          final storage = GetStorage();
          storage.write('userName', state.user.name);

          // Navigate to Tutorial Screen using GetX
          Get.offAllNamed(AppRoutes.tutorial);
        } else if (state is RegisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  // Image
                  Image.asset(
                    'assets/images/mindy_regist.png',
                    height: 175.13546752929688,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.cloud,
                      size: 80,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Title
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

                  // Name field
                  _buildTextField(
                    controller: _nameController,
                    label: 'Nama',
                    assetIcon: 'assets/images/profile.png',
                    onChanged: (value) {
                      context.read<RegisterBloc>().add(RegisterNameChanged(value));
                    },
                    validator: (v) => v!.isEmpty ? 'Nama harus diisi' : null,
                  ),

                  const SizedBox(height: 18),

                  // Email field
                  _buildTextField(
                    controller: _emailController,
                    label: 'Email',
                    assetIcon: 'assets/images/email.png',
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      context.read<RegisterBloc>().add(RegisterEmailChanged(value));
                    },
                    validator: (v) {
                      if (v!.isEmpty) return 'Email harus diisi';
                      if (!v.contains('@')) return 'Email tidak valid';
                      return null;
                    },
                  ),

                  const SizedBox(height: 18),

                  // Password field
                  _buildPasswordField(
                    controller: _passwordController,
                    label: 'Kata Sandi',
                    obscureText: _obscurePassword,
                    onToggle: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                    assetLock: 'assets/images/lock.png',
                    assetEye: 'assets/images/eye.png',
                    onChanged: (value) {
                      context.read<RegisterBloc>().add(RegisterPasswordChanged(value));
                    },
                    validator: (v) => v!.length < 6 ? 'Minimal 6 karakter' : null,
                  ),

                  const SizedBox(height: 18),

                  // Confirm Password field
                  _buildPasswordField(
                    controller: _confirmPasswordController,
                    label: 'Konfirmasi Kata Sandi',
                    obscureText: _obscureConfirmPassword,
                    onToggle: () {
                      setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
                    },
                    assetLock: 'assets/images/lock.png',
                    assetEye: 'assets/images/eye.png',
                    onChanged: (value) {
                      context.read<RegisterBloc>().add(RegisterConfirmPasswordChanged(value));
                    },
                    validator: (v) {
                      if (v != _passwordController.text) {
                        return 'Kata sandi tidak cocok';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 24),

                  // Checkbox
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
                            color: _agreeTerms ? const Color(0xFF4597E6) : null,
                          ),
                          child: _agreeTerms
                              ? const Icon(
                                  Icons.check,
                                  size: 14,
                                  color: Colors.white,
                                )
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

                  // Button Daftar
                  BlocBuilder<RegisterBloc, RegisterState>(
                    builder: (context, state) {
                      final isLoading = state is RegisterLoading;
                      return _buildRegisterButton(
                        isLoading: isLoading,
                        onTap: isLoading ? null : _handleRegister,
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  // Login link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Sudah punya akun? '),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.login);
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

  Widget _buildRegisterButton({
    required bool isLoading,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          gradient: isLoading
              ? null
              : const LinearGradient(
                  colors: [
                    Color(0xFF4597E6),
                    Color(0xFF7BBEFF),
                    Color(0xFF83DFC6),
                  ],
                ),
          color: isLoading ? Colors.grey : null,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text(
                  'Daftar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      if (!_agreeTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Harap setujui syarat dan ketentuan'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }
      context.read<RegisterBloc>().add(
            RegisterSubmitted(
              name: _nameController.text,
              email: _emailController.text,
              password: _passwordController.text,
              confirmPassword: _confirmPasswordController.text,
            ),
          );
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String assetIcon,
    TextInputType keyboardType = TextInputType.text,
    Function(String)? onChanged,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: Image.asset(assetIcon, width: 20),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFF4597E6), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
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
    Function(String)? onChanged,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
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
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFF4597E6), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
      ),
    );
  }
}