import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String iconPath;

  final bool obscureText;
  final VoidCallback? onToggle;
  final Widget? suffixIcon;

  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.iconPath,
    this.obscureText = false,
    this.onToggle,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,

      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,

        style: const TextStyle(
          fontSize: 14,
        ),

        decoration: InputDecoration(
          hintText: hintText,

          hintStyle: const TextStyle(
            color: Color(0xff8F8F8F),
            fontSize: 14,
          ),

          filled: true,
          fillColor: Colors.white,

          // 🔹 PREFIX ICON
          prefixIcon: Padding(
            padding: const EdgeInsets.all(14),

            child: Image.asset(
              iconPath,
              width: 20,
              height: 20,
            ),
          ),

          prefixIconConstraints:
              const BoxConstraints(
            minWidth: 50,
            minHeight: 50,
          ),

          // 🔹 SUFFIX ICON
          suffixIcon: suffixIcon,

          contentPadding:
              const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 14,
          ),

          // 🔹 BORDER
          enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(16),

            borderSide: BorderSide(
              color: AppColors.secondary
                  .withValues(alpha: 0.7),
              width: 1,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(16),

            borderSide: const BorderSide(
              color: AppColors.primary,
              width: 1.5,
            ),
          ),

          errorBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(16),

            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),

          focusedErrorBorder:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(16),

            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}