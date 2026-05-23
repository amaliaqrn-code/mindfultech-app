import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/styles.dart';
import '../controllers/journey_controller.dart';
import '../data/journey_data.dart';

class JourneyScreen extends StatelessWidget {
  const JourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JourneyController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        final totalDays = controller.totalDays.value;
        final dayInCycle = controller.dayInCycle;

        return Column(
          children: [
            // Top section (white background)
            _buildTopSection(context, controller, totalDays),

            // Map section (scrollable denah.png with overlays)
            Expanded(
              child: _buildMapSection(
                  context, controller, totalDays, dayInCycle),
            ),
          ],
        );
      }),
    );
  }

  /// Top section with header, cloud character, and info card
Widget _buildTopSection(
  BuildContext context,
  JourneyController controller,
  int totalDays,
) {
  return SafeArea(
    bottom: false,
    child: Column(
      children: [
        // HEADER
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 28,
          ),
          child: Row(
            children: [
              // BACK BUTTON
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary,
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColors.primary,
                    size: 18,
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // TITLE
              Text(
                'Journey Map',
                style: AppTextStyles.heading.copyWith(
                  fontSize: 28,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),

        // CLOUD + CARD
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            // CARD
            Padding(
              padding: const EdgeInsets.only(
                top: 40,
                left: 8,
                right: 8,
              ),
              child: _buildProgressCard(totalDays),
            ),

            // CLOUD CHARACTER
            Positioned(
              top: -30,
              child: _buildCloudWithSpeech(controller),
            ),
          ],
        ),

        const SizedBox(height: 14),
      ],
    ),
  );
}

/// Cute cloud character with speech bubble
Widget _buildCloudWithSpeech(JourneyController controller) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      // SPEECH BUBBLE
      Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF4CAF50),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          controller.getMotivationalMessage(),
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),

      const SizedBox(width: 4),

      // CLOUD IMAGE
      Image.asset(
        'assets/images/journey/awan.png',
        width: 100,
        height: 80,
        fit: BoxFit.contain,
      ),
    ],
  );
}

  /// Progress card showing days and special reward
  Widget _buildProgressCard(int totalDays) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Flag icon
          Image.asset(
            'assets/images/journey/bendera.png',
            width: 24,
            height: 24,
            color: AppColors.primary,
          ),
          const SizedBox(width: 8),
          // Progress text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Progress Perjalananmu',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 2),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '$totalDays',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      TextSpan(
                        text: ' / ${JourneyData.maxDays} hari',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Divider
          Container(
            width: 1,
            height: 40,
            color: Colors.grey.shade200,
          ),
          const SizedBox(width: 12),
          // Special reward section
          Image.asset(
            'assets/images/journey/hadiah.png',
            width: 24,
            height: 24,
            color: AppColors.primary,
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Hadiah Spesial\nMenaantimu',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Main map area with denah.png background and overlays
  Widget _buildMapSection(BuildContext context, JourneyController controller,
      int totalDays, int dayInCycle) {
    // denah.png original dimensions: ~830 x 1108
    const imageAspectRatio = 830.0 / 1108.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final mapWidth = constraints.maxWidth;
        final mapHeight = mapWidth / imageAspectRatio;

        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: SingleChildScrollView(
            // Start scrolled near the bottom (Day 1 area)
            controller: ScrollController(
              initialScrollOffset:
                  (mapHeight - constraints.maxHeight).clamp(0.0, double.infinity),
            ),
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              width: mapWidth,
              height: mapHeight,
              child: Stack(
                children: [
                  // Background denah image (already has greyscale built into locked areas)
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/journey/denah.png',
                      width: mapWidth,
                      height: mapHeight,
                      fit: BoxFit.fill,
                    ),
                  ),

                  // Waypoint pin markers
                  ..._buildWaypointMarkers(
                    context, controller, dayInCycle, mapWidth, mapHeight,
                  ),

                  // Cloud character at current day position
                  if (dayInCycle > 0 && dayInCycle <= 7)
                    _buildCloudOnMap(dayInCycle, mapWidth, mapHeight),

                  // Special reward card (Hadiah Spesial)
                  _buildSpecialRewardCard(mapWidth, mapHeight),

                  // Chat bubble near Day 1
                  if (dayInCycle >= 1)
                    _buildChatBubble(mapWidth, mapHeight),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Build waypoint markers at positions along the winding path
  List<Widget> _buildWaypointMarkers(BuildContext context,
      JourneyController controller, int dayInCycle, double mapWidth,
      double mapHeight) {
    final markers = <Widget>[];

    for (int day = 1; day <= 7; day++) {
      final pos = JourneyData.waypointPositions[day - 1];
      final x = pos['x']! * mapWidth;
      final y = pos['y']! * mapHeight;

      final isUnlocked = day <= dayInCycle;
      final isCompleted = day < dayInCycle;
      final isCurrent = day == dayInCycle;

      markers.add(
        Positioned(
          left: x - 20,
          top: y - 48,
          child: GestureDetector(
            onTap: isUnlocked
                ? () => _showDayDetail(context, day, dayInCycle)
                : null,
            child: _buildMapPin(day, isUnlocked, isCompleted, isCurrent),
          ),
        ),
      );
    }

    return markers;
  }

  /// Build a single map pin marker (circle with number + pointer tail)
  Widget _buildMapPin(
      int day, bool isUnlocked, bool isCompleted, bool isCurrent) {
    Color bgColor;
    Color textColor;
    Color borderColor;

    if (isCurrent) {
      bgColor = AppColors.primary;
      textColor = Colors.white;
      borderColor = Colors.white;
    } else if (isCompleted) {
      bgColor = const Color(0xFF4CAF50);
      textColor = Colors.white;
      borderColor = Colors.white;
    } else {
      bgColor = Colors.grey.shade500;
      textColor = Colors.white;
      borderColor = Colors.grey.shade300;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Pin head (circle with number)
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: bgColor,
            border: Border.all(color: borderColor, width: 2.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: isUnlocked
                ? Text(
                    '$day',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  )
                : Icon(
                    Icons.lock,
                    color: textColor,
                    size: 16,
                  ),
          ),
        ),
        // Pin tail (triangle pointer)
        CustomPaint(
          size: const Size(14, 10),
          painter: _PinTailPainter(color: borderColor),
        ),
      ],
    );
  }

  /// Cloud character positioned above the current day pin
  Widget _buildCloudOnMap(int dayInCycle, double mapWidth, double mapHeight) {
    final pos = JourneyData.waypointPositions[dayInCycle - 1];
    final x = pos['x']! * mapWidth;
    final y = pos['y']! * mapHeight;

    return Positioned(
      left: x - 30,
      top: y - 100,
      child: Image.asset(
        'assets/images/journey/awan1.png',
        width: 50,
        height: 36,
        fit: BoxFit.contain,
      ),
    );
  }

  /// Special reward card overlay (left side of map, mid-height)
  Widget _buildSpecialRewardCard(double mapWidth, double mapHeight) {
    return Positioned(
      left: 12,
      top: mapHeight * 0.52,
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Lock icon top-right
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lock,
                  size: 13,
                  color: Colors.grey,
                ),
              ),
            ),
            // "Hadiah Spesial" title
            const Text(
              'Hadiah Spesial',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 6),
            // Treasure chest image
            Image.asset(
              'assets/images/journey/hartaKarun.png',
              width: 48,
              height: 40,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 6),
            // Description text
            Text(
              'Mulai Fokus Hari\nIni, Raih Hadiah di\nHari ke-30!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Chat bubble near Day 1
  Widget _buildChatBubble(double mapWidth, double mapHeight) {
    return Positioned(
      left: mapWidth * 0.38,
      top: mapHeight * 0.84,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          'Mulai dari langkah\nkecil, ya',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
            height: 1.3,
          ),
        ),
      ),
    );
  }

  /// Show day detail bottom sheet
  void _showDayDetail(BuildContext context, int day, int dayInCycle) {
    final isCompleted = day < dayInCycle;
    final isCurrentDay = day == dayInCycle;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            // Day indicator circle
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted
                    ? const Color(0xFF4CAF50).withValues(alpha: 0.15)
                    : isCurrentDay
                        ? AppColors.primary.withValues(alpha: 0.1)
                        : Colors.grey.shade100,
              ),
              child: Center(
                child: isCurrentDay
                    ? Image.asset(
                        'assets/images/journey/awan.png',
                        width: 50,
                        height: 38,
                      )
                    : Text(
                        '$day',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: isCompleted
                              ? const Color(0xFF4CAF50)
                              : AppColors.textGrey,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Hari $day',
              style: AppTextStyles.heading,
            ),
            const SizedBox(height: 24),
            // Status info
            if (isCompleted)
              _buildStatusRow(
                icon: Icons.check_circle,
                color: const Color(0xFF4CAF50),
                text: 'Sesi fokus berhasil diselesaikan!',
              )
            else if (isCurrentDay)
              _buildStatusRowWithImage(
                imagePath: 'assets/images/journey/awan1.png',
                color: AppColors.primary,
                text: 'Kamu sedang berada di hari ini!',
              )
            else
              _buildStatusRow(
                icon: Icons.lock,
                color: Colors.grey,
                text: 'Selesaikan sesi sebelumnya untuk membuka.',
              ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRow({
    required IconData icon,
    required Color color,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRowWithImage({
    required String imagePath,
    required Color color,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Image.asset(imagePath, width: 30, height: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter for the pin tail (small triangle below the circle)
class _PinTailPainter extends CustomPainter {
  final Color color;

  _PinTailPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}