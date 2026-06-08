import 'package:flutter/material.dart';
import 'password_success_page.dart';
import '../../../core/constants/colors.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() =>
      _ForgotPasswordPageState();
}

class _ForgotPasswordPageState
    extends State<ForgotPasswordPage> {

  final TextEditingController
      _passwordController =
      TextEditingController();

  final TextEditingController
      _confirmPasswordController =
      TextEditingController();

  final _formKey =
      GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword =
      true;

  void _handleResetPassword() {

    if (_formKey.currentState!
        .validate()) {

      Navigator.pushReplacement(
        context,

        MaterialPageRoute(
          builder: (context) =>
              const PasswordSuccessPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          AppColors.background,

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 24,
          ),

          child: Form(
            key: _formKey,

            child: Column(
              children: [

                const SizedBox(height: 100),

                // ☁️ IMAGE
                Image.asset(
                  'assets/images/mindy_lupa_password.png',
                  height: 170,

                  errorBuilder: (_, _, _) {
                    return const Icon(
                      Icons.cloud,
                      size: 120,
                    );
                  },
                ),

                const SizedBox(height: 28),

                // 🌈 TITLE
                ShaderMask(
                  shaderCallback:
                      (bounds) {

                    return AppColors
                        .primaryGradient
                        .createShader(
                            bounds);
                  },

                  child: const Text(
                    'Lupa Kata Sandi',

                    style: TextStyle(
                      fontSize: 28,
                      fontWeight:
                          FontWeight.bold,
                      color:
                          Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // 📝 DESC
                const Text(
                  'Kami akan membantu Anda untuk membuat yang baru.',

                  textAlign:
                      TextAlign.center,

                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Color(
                        0xff655F5F),
                  ),
                ),

                const SizedBox(height: 42),

                // 🔐 PASSWORD
                CustomTextField(
                  controller:
                      _passwordController,

                  hintText:
                      'Kata Sandi Baru',

                  iconPath:
                      'assets/images/key.png',

                  obscureText:
                      _obscurePassword,

                  validator: (value) {

                    if (value == null ||
                        value.isEmpty) {

                      return 'Kata sandi wajib diisi';
                    }

                    if (value.length <
                        6) {

                      return 'Minimal 6 karakter';
                    }

                    return null;
                  },

                  suffixIcon:
                      IconButton(

                    onPressed: () {

                      setState(() {

                        _obscurePassword =
                            !_obscurePassword;
                      });
                    },

                    icon: Image.asset(
                      'assets/images/eye.png',
                      width: 20,
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // 🔐 CONFIRM PASSWORD
                CustomTextField(
                  controller:
                      _confirmPasswordController,

                  hintText:
                      'Konfirmasi Kata Sandi Baru',

                  iconPath:
                      'assets/images/key.png',

                  obscureText:
                      _obscureConfirmPassword,

                  validator: (value) {

                    if (value !=
                        _passwordController
                            .text) {

                      return 'Kata sandi tidak cocok';
                    }

                    return null;
                  },

                  suffixIcon:
                      IconButton(

                    onPressed: () {

                      setState(() {

                        _obscureConfirmPassword =
                            !_obscureConfirmPassword;
                      });
                    },

                    icon: Image.asset(
                      'assets/images/eye.png',
                      width: 20,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // 🚀 BUTTON
                CustomButton(
                  text:
                      'Buat Kata Sandi Baru',

                  onTap:
                      _handleResetPassword,
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}