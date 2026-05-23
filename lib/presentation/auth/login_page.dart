import 'package:flutter/material.dart';
import 'package:mindfultech_app/presentation/auth/forgot_password.dart';
import 'package:mindfultech_app/presentation/auth/registrasi_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20),

                  // Maskot
                  Image.asset(
                    'assets/images/login.png',
                    height: 100,
                    errorBuilder: (_, __, ___) =>
                        Icon(Icons.cloud, size: 80, color: Colors.grey),
                  ),
                  SizedBox(height: 24),

                  // Judul gradien
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [Color(0xFF4597E6), Color(0xFF7BBEFF), Color(0xFF83DFC6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Text(
                      'Masuk ke Mindy',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Teman fokus yang siap menemani harimu',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF655F5F),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32),

                  _buildTextField(
                    controller: _nameController,
                    label: 'Nama',
                    assetIcon: 'assets/images/profile.png',
                    validator: (v) => v!.isEmpty ? 'Nama harus diisi' : null,
                  ),
                  SizedBox(height: 18),
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
                  SizedBox(height: 18),
                  _buildPasswordField(
                    controller: _passwordController,
                    label: 'Kata Sandi',
                    obscureText: _obscurePassword,
                    onToggle: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    assetLock: 'assets/images/lock.png',
                    assetEye: 'assets/images/eye.png',
                    validator: (v) => v!.length < 6 ? 'Minimal 6 karakter' : null,
                  ),
                  SizedBox(height: 8),

                  // Lupa kata sandi
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ForgotPasswordPage(),
                          ),
                        );
                      },

                      child: const Text(
                        'Lupa Kata Sandi?',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF4597E6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32),

                  // Tombol Masuk
                  GestureDetector(
                    onTap: _handleLogin,
                    child: Container(
                      width: 364,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF4597E6), Color(0xFF7BBEFF), Color(0xFF83DFC6)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'Masuk',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Divider Atau
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey.shade300)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'Atau',
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey.shade300)),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Tombol Google
                  GestureDetector(
                    onTap: () {
                      // TODO: login dengan Google
                    },
                    child: Container(
                      width: 364,
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade300, width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/google_logo.png',
                            width: 22,
                            height: 22,
                            errorBuilder: (_, __, ___) =>
                                Icon(Icons.g_mobiledata, size: 26, color: Colors.red),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Masuk dengan Google',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF655F5F),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Link ke Registrasi
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Belum punya akun? ',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegistrasiPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Daftar',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4597E6),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String assetIcon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return SizedBox(
      width: 364,
      height: 52,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
          prefixIcon: Padding(
            padding: EdgeInsets.all(12.0),
            child: Image.asset(assetIcon, width: 20, height: 20),
          ),
          prefixIconConstraints: BoxConstraints(minWidth: 44, maxWidth: 44),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Color(0xFF4597E6), width: 1.5),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
    String? Function(String?)? validator,
  }) {
    return SizedBox(
      width: 364,
      height: 52,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
          prefixIcon: Padding(
            padding: EdgeInsets.all(12.0),
            child: Image.asset(assetLock, width: 20, height: 20),
          ),
          prefixIconConstraints: BoxConstraints(minWidth: 44, maxWidth: 44),
          suffixIcon: IconButton(
            icon: Image.asset(assetEye, width: 20, height: 20),
            onPressed: onToggle,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Color(0xFF4597E6), width: 1.5),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, '/journey');
    }
  }
}