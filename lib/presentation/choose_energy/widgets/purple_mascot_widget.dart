import 'package:flutter/material.dart';
import '../theme/purple_theme.dart';

/// Purple Mascot Widget - Cloud mascot with lightning bolts and stars
class PurpleMascotWidget extends StatefulWidget {
  final double size;

  const PurpleMascotWidget({
    super.key,
    this.size = 120,
  });

  @override
  State<PurpleMascotWidget> createState() => _PurpleMascotWidgetState();
}

class _PurpleMascotWidgetState extends State<PurpleMascotWidget>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  late AnimationController _pulseController;
  late Animation<double> _floatAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: 0, end: 12).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size + 80,
      height: widget.size + 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Lightning bolts and stars
          Positioned(
            top: 5,
            left: 15,
            child: _buildLightningBolt(),
          ),
          Positioned(
            top: 15,
            right: 20,
            child: Transform.rotate(
              angle: 0.3,
              child: _buildStar(16),
            ),
          ),
          Positioned(
            bottom: 35,
            right: 10,
            child: _buildLightningBolt(),
          ),
          Positioned(
            bottom: 25,
            left: 5,
            child: Transform.rotate(
              angle: -0.2,
              child: _buildStar(12),
            ),
          ),
          Positioned(
            top: 25,
            right: 50,
            child: Transform.rotate(
              angle: 0.5,
              child: _buildStar(10),
            ),
          ),

          // Main mascot (cloud)
          AnimatedBuilder(
            animation: _floatAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, -_floatAnimation.value),
                child: child,
              );
            },
            child: _buildCloudMascot(),
          ),
        ],
      ),
    );
  }

  Widget _buildLightningBolt() {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: Icon(
            Icons.bolt,
            color: PurpleTheme.violetAccent,
            size: 20,
          ),
        );
      },
    );
  }

  Widget _buildStar(double size) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: 0.5 + (_pulseAnimation.value - 1.0) * 3,
          child: Transform.scale(
            scale: 0.8 + (_pulseAnimation.value - 1.0) * 2,
            child: Icon(
              Icons.star,
              color: PurpleTheme.primaryPurple,
              size: size,
            ),
          ),
        );
      },
    );
  }

  Widget _buildCloudMascot() {
    return Container(
      width: widget.size,
      height: widget.size * 0.65,
      decoration: BoxDecoration(
        color: PurpleTheme.backgroundWhite,
        borderRadius: BorderRadius.circular(widget.size / 2),
        boxShadow: [
          BoxShadow(
            color: PurpleTheme.shadowColor,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Cloud puffs
          Positioned(
            top: widget.size * 0.12,
            left: widget.size * 0.15,
            child: Container(
              width: widget.size * 0.22,
              height: widget.size * 0.32,
              decoration: BoxDecoration(
                color: PurpleTheme.backgroundCream,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: widget.size * 0.08,
            right: widget.size * 0.18,
            child: Container(
              width: widget.size * 0.28,
              height: widget.size * 0.38,
              decoration: BoxDecoration(
                color: PurpleTheme.backgroundCream,
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Face with excited expression
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Left eye (excited)
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: PurpleTheme.primaryPurple,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 18),
                // Lightning icon
                Icon(
                  Icons.bolt,
                  color: PurpleTheme.primaryPurple,
                  size: widget.size * 0.2,
                ),
                const SizedBox(width: 18),
                // Right eye (excited)
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: PurpleTheme.primaryPurple,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}