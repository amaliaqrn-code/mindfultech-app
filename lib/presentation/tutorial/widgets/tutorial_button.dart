import 'package:flutter/material.dart';

class TutorialButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isWhite;

  const TutorialButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isWhite = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 58,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: isWhite ? Colors.white : null,
          border: isWhite
              ? Border.all(color: Colors.grey.shade300)
              : null,
          gradient: isWhite
              ? null
              : const LinearGradient(
                  colors: [
                    Color(0xff4597E6),
                    Color(0xff7BBEFF),
                    Color(0xff83DFC6),
                  ],
                ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isWhite ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}