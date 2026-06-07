import 'package:flutter/material.dart';
import '../theme/green_theme.dart';

/// Green Mascot Widget - Cloud mascot with Mindy for low energy
class GreenMascotWidget extends StatefulWidget {
  final double size;
  final String? assetPath;

  const GreenMascotWidget({
    super.key,
    this.size = 120,
    this.assetPath,
  });

  @override
  State<GreenMascotWidget> createState() => _GreenMascotWidgetState();
}

class _GreenMascotWidgetState extends State<GreenMascotWidget>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  String get _assetPath => widget.assetPath ?? 'assets/images/energirendah/energi_rendah_alternative.png';

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -_floatAnimation.value),
          child: child,
        );
      },
      child: Image.asset(
        _assetPath,
        width: widget.size,
        height: widget.size * 0.85,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: widget.size,
            height: widget.size * 0.65,
            decoration: BoxDecoration(
              color: GreenTheme.sageGreenLight,
              borderRadius: BorderRadius.circular(widget.size / 2),
              boxShadow: [
                BoxShadow(
                  color: GreenTheme.shadowColor,
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.eco_rounded,
                color: GreenTheme.sageGreen,
                size: widget.size * 0.5,
              ),
            ),
          );
        },
      ),
    );
  }
}