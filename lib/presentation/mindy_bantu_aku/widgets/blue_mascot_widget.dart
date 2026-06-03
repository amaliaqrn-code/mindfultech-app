import 'package:flutter/material.dart';
import '../theme/blue_theme.dart';

/// Blue Mascot Widget - Cloud mascot from asset
class BlueMascotWidget extends StatefulWidget {
  final double size;

  const BlueMascotWidget({
    super.key,
    this.size = 120,
  });

  @override
  State<BlueMascotWidget> createState() => _BlueMascotWidgetState();
}

class _BlueMascotWidgetState extends State<BlueMascotWidget>
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

    _floatAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

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
        'assets/images/energisedang/mindy.png',
        width: widget.size,
        height: widget.size * 0.85,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: widget.size,
            height: widget.size * 0.65,
            decoration: BoxDecoration(
              color: BlueTheme.backgroundWhite,
              borderRadius: BorderRadius.circular(widget.size / 2),
              boxShadow: [
                BoxShadow(
                  color: BlueTheme.shadowColor,
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Center(
              child: Text('😊', style: TextStyle(fontSize: 40)),
            ),
          );
        },
      ),
    );
  }
}