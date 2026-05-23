import 'package:flutter/material.dart';
import 'journey_node.dart';
import '../models/journey_level_model.dart';
import '../../../core/constants/colors.dart';

class JourneyPath extends StatelessWidget {
  final List<JourneyLevelModel> levels;
  final int currentLevel;
  final int totalDays;
  final Function(int) onNodeTap;

  const JourneyPath({
    super.key,
    required this.levels,
    required this.currentLevel,
    required this.totalDays,
    required this.onNodeTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Path background
          Positioned(
            left: 20,
            right: 20,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          // Active progress on path
          Positioned(
            left: 20,
            child: Container(
              height: 60,
              width: _calculateActivePathWidth(context),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.3),
                    AppColors.secondary.withValues(alpha: 0.3),
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          // Journey nodes
          Positioned(
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: _canScroll()
                  ? const BouncingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _buildNodes(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildNodes() {
    final nodes = <Widget>[];
    final unlockedLevels = _getUnlockedLevels();

    for (int i = 0; i < levels.length; i++) {
      final level = levels[i];
      final isUnlocked = unlockedLevels.contains(level.level);
      final isCompleted = level.level < currentLevel;
      final isCurrentLevel = level.level == currentLevel;

      nodes.add(
        JourneyNode(
          level: level,
          isUnlocked: isUnlocked,
          isCurrentLevel: isCurrentLevel,
          isCompleted: isCompleted,
          onTap: () => onNodeTap(level.level),
        ),
      );

      if (i < levels.length - 1) {
        nodes.add(_buildConnector(isCompleted || level.level < currentLevel));
      }
    }

    return nodes;
  }

  Widget _buildConnector(bool isActive) {
    return Container(
      width: 30,
      height: 3,
      decoration: BoxDecoration(
        color: isActive ? AppColors.secondary : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Set<int> _getUnlockedLevels() {
    if (totalDays < 1) return {1};
    if (totalDays < 7) return {1};
    if (totalDays < 14) return {1, 2};
    if (totalDays < 30) return {1, 2, 3};
    if (totalDays < 60) return {1, 2, 3, 4};
    return {1, 2, 3, 4, 5};
  }

  bool _canScroll() {
    return currentLevel > 3;
  }

  double _calculateActivePathWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final nodeSize = 80.0;
    final connectorSize = 30.0;
    final padding = 40.0;

    if (totalDays >= 60) {
      return screenWidth - padding - 20;
    }

    final unlockedCount = _getUnlockedLevels().length;
    return (nodeSize * unlockedCount) + (connectorSize * (unlockedCount - 1));
  }
}