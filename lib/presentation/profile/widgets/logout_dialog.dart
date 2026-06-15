import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindfultech_app/presentation/auth/bloc/auth/auth_cubit.dart'; // Sesuaikan path AuthCubit kamu
import 'package:mindfultech_app/presentation/splash/pages/splash_page.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onLogout;

  const LogoutDialog({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.warning_rounded, color: Colors.red, size: 70),
            const SizedBox(height: 20),
            const Text(
              'Apakah kamu yakin ingin keluar?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Kamu dapat masuk kembali kapan saja untuk melanjutkan perjalananmu bersama mindy',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Batal'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final authCubit = context.read<AuthCubit>();

                      await authCubit.logout();

                      if (!context.mounted) return;

                      Navigator.of(
                        context,
                        rootNavigator: true,
                      ).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const SplashPage()),
                        (route) => false,
                      );
                    },
                    child: const Text("Keluar"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
