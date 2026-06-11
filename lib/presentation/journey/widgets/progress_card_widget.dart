import 'package:flutter/material.dart';

class ProgressCardWidget extends StatelessWidget {
  final int currentProgress;
  final int maxProgress;

  const ProgressCardWidget({
    super.key,
    required this.currentProgress,
    required this.maxProgress,
  });

  @override
  Widget build(BuildContext context) {
    double progressPercent = currentProgress / maxProgress;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Progress ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 12),
              Text(
                '$currentProgress / $maxProgress',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              // Progress Bar Background
              Container(
                height: 24,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xff4c5199),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              // Progress Bar Fill
              FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progressPercent,
                child: Container(
                  height: 24,
                  decoration: BoxDecoration(
                    color: const Color(0xffc5bce5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}