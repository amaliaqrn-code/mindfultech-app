import 'package:flutter/material.dart';
import '../theme/blue_theme.dart';

/// Blue Mascot Widget - Cloud mascot reading a book with stars
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
  late AnimationController _starController;
  late Animation<double> _floatAnimation;
  late Animation<double> _star1Animation;
  late Animation<double> _star2Animation;
  late Animation<double> _star3Animation;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _starController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _star1Animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _starController, curve: Curves.easeInOut),
    );

    _star2Animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _starController,
        curve: const Interval(0.2, 1, curve: Curves.easeInOut),
      ),
    );

    _star3Animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _starController,
        curve: const Interval(0.4, 1, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    _starController.dispose();
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
          // Floating stars
          Positioned(
            top: 10,
            left: 20,
            child: _buildStar(_star1Animation, 16),
          ),
          Positioned(
            top: 20,
            right: 30,
            child: _buildStar(_star2Animation, 12),
          ),
          Positioned(
            bottom: 30,
            right: 15,
            child: _buildStar(_star3Animation, 14),
          ),
          Positioned(
            bottom: 20,
            left: 10,
            child: _buildStar(
              CurvedAnimation(
                parent: _starController,
                curve: const Interval(0.6, 1),
              ),
              10,
            ),
          ),

          // Main mascot (cloud reading book)
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

  Widget _buildStar(Animation<double> animation, double size) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Opacity(
          opacity: 0.4 + (animation.value * 0.6),
          child: Transform.scale(
            scale: 0.6 + (animation.value * 0.4),
            child: Icon(
              Icons.star,
              color: BlueTheme.primaryBlue,
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
                color: BlueTheme.backgroundCream,
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
                color: BlueTheme.backgroundCream,
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Face with book
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Left eye
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: BlueTheme.primaryBlue,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 16),
                // Book icon
                Icon(
                  Icons.menu_book_rounded,
                  color: BlueTheme.primaryBlue,
                  size: widget.size * 0.22,
                ),
                const SizedBox(width: 16),
                // Right eye
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: BlueTheme.primaryBlue,
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
