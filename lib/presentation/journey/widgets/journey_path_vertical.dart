import 'package:flutter/material.dart';
import 'journey_waypoint.dart';

class JourneyPathVertical extends StatefulWidget {
  final int totalDays;
  final Function(int) onDayTap;

  const JourneyPathVertical({
    super.key,
    required this.totalDays,
    required this.onDayTap,
  });

  @override
  State<JourneyPathVertical> createState() => _JourneyPathVerticalState();
}

class _JourneyPathVerticalState extends State<JourneyPathVertical> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentDay();
    });
  }

  void _scrollToCurrentDay() {
    if (_scrollController.hasClients) {
      final offset = (widget.totalDays - 1) * 100.0;
      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void didUpdateWidget(JourneyPathVertical oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.totalDays != widget.totalDays) {
      _scrollToCurrentDay();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const maxDays = 60;
    final currentDay = widget.totalDays;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/journey_map_reference.png'),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: _getBackgroundGradient(currentDay),
        ),
        child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemCount: maxDays,
        itemBuilder: (context, index) {
          final dayNumber = index + 1;
          final isUnlocked = dayNumber <= currentDay + 1;
          final isCurrentDay = dayNumber == currentDay;
          final isCompleted = dayNumber < currentDay;
          final level = _getLevelForDay(dayNumber);

          return JourneyWaypoint(
            dayNumber: dayNumber,
            level: level,
            isUnlocked: isUnlocked,
            isCurrentDay: isCurrentDay,
            isCompleted: isCompleted,
            showCloud: isCurrentDay,
            onTap: isUnlocked ? () => widget.onDayTap(dayNumber) : null,
          );
        },
      ),
      ),
    );
  }

  LinearGradient _getBackgroundGradient(int currentDay) {
    if (currentDay <= 7) {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFE8F5E9),
          Color(0xFFC8E6C9),
          Color(0xFFA5D6A7),
        ],
      );
    } else if (currentDay <= 14) {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFFFF9C4),
          Color(0xFFFFE082),
          Color(0xFFFFCA28),
        ],
      );
    } else if (currentDay <= 30) {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFB3E5FC),
          Color(0xFF81D4FA),
          Color(0xFF4FC3F7),
        ],
      );
    } else if (currentDay <= 60) {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFEDE7F6),
          Color(0xFFD1C4E9),
          Color(0xFFB39DDB),
        ],
      );
    } else {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF1A237E),
          Color(0xFF311B92),
          Color(0xFF4A148C),
        ],
      );
    }
  }

  String _getLevelForDay(int day) {
    if (day <= 7) return '🌱 Grassland';
    if (day <= 14) return '🌤 Sunny Hill';
    if (day <= 30) return '🌊 Calm Lake';
    if (day <= 60) return '🏔 Focus Mountain';
    return '🌌 Peace Sky';
  }
}
