import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import 'login_page.dart';

class PasswordSuccessPage extends StatelessWidget {
  const PasswordSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff4597E6),
              Color(0xff83DFC6),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [

              // ✅ ICON
              Container(
                width: 90,
                height: 90,

                decoration: BoxDecoration(
                  color: Colors.white
                      .withValues(alpha: 0.15),

                  shape: BoxShape.circle,
                ),

                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 50,
                ),
              ),

              const SizedBox(height: 36),

              // 🌟 TITLE
              const Text(
                'Kata Sandi\nDiperbarui!',

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 34,
                  height: 1.2,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 24),

              // 📝 DESC
              const Text(
                'Kata sandi Anda\n telah berhasil direset.',

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 80),

              // 🚀 BUTTON
              GestureDetector(
                onTap: () {

                  Navigator.pushAndRemoveUntil(
                    context,

                    MaterialPageRoute(
                      builder: (context) =>
                         LoginPage(),
                    ),

                    (route) => false,
                  );
                },

                child: Container(
                  width: 160,
                  height: 52,

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(
                      30,
                    ),
                  ),

                  child: const Center(
                    child: Text(
                      'Kembali',

                      style: TextStyle(
                        fontSize: 15,
                        fontWeight:
                            FontWeight.w600,

                        color:
                            AppColors.textDark,
                      ),
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
}