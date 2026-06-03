import 'package:flutter/material.dart';
import '../theme/green_theme.dart';

/// Mascot Widget - Cloud mascot with floating leaves
class MascotWidget extends StatefulWidget {
  final double size;

  const MascotWidget({
    super.key,
    this.size = 120,
  });

  @override
  State<MascotWidget> createState() => _MascotWidgetState();
}

class _MascotWidgetState extends State<MascotWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatAnimation;
  late Animation<double> _leaf1Animation;
  late Animation<double> _leaf2Animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _leaf1Animation = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _leaf2Animation = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size + 60,
      height: widget.size + 20,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Left floating leaf
          Positioned(
            left: 0,
            child: AnimatedBuilder(
              animation: _leaf1Animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(-5, -_leaf1Animation.value),
                  child: Transform.rotate(
                    angle: -0.3,
                    child: Icon(
                      Icons.eco,
                      color: GreenTheme.sageGreen.withValues(alpha: 0.7),
                      size: 24,
                    ),
                  ),
                );
              },
            ),
          ),

          // Right floating leaf
          Positioned(
            right: 0,
            child: AnimatedBuilder(
              animation: _leaf2Animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(5, -_leaf2Animation.value),
                  child: Transform.rotate(
                    angle: 0.3,
                    child: Icon(
                      Icons.eco,
                      color: GreenTheme.mintGreen.withValues(alpha: 0.7),
                      size: 20,
                    ),
                  ),
                );
              },
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
            child: _buildCloud(),
          ),
        ],
      ),
    );
  }

  Widget _buildCloud() {
    return Container(
      width: widget.size,
      height: widget.size * 0.6,
      decoration: BoxDecoration(
        color: GreenTheme.backgroundWhite,
        borderRadius: BorderRadius.circular(widget.size / 2),
        boxShadow: [
          BoxShadow(
            color: GreenTheme.shadowColor,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Cloud puffs
          Positioned(
            top: widget.size * 0.15,
            left: widget.size * 0.15,
            child: Container(
              width: widget.size * 0.25,
              height: widget.size * 0.35,
              decoration: BoxDecoration(
                color: GreenTheme.backgroundCream,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: widget.size * 0.1,
            right: widget.size * 0.2,
            child: Container(
              width: widget.size * 0.3,
              height: widget.size * 0.4,
              decoration: BoxDecoration(
                color: GreenTheme.backgroundCream,
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Face placeholder (minimalist)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.spa,
                  color: GreenTheme.sageGreen,
                  size: widget.size * 0.25,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
