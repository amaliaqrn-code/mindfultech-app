import 'package:flutter/material.dart';
import '../models/energy_option_model.dart';

class EnergyCard extends StatelessWidget {
  final EnergyOption option;
  final bool isSelected;
  final VoidCallback onTap;

  const EnergyCard({
    super.key,
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: option.backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            _buildImageContainer(),
            const SizedBox(width: 14),
            Expanded(child: _buildTextContent()),
            const SizedBox(width: 12),
            _buildSelectionIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageContainer() {
    return SizedBox(
      width: 56,
      height: 56,
      child: Image.asset(
        option.imageAsset,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildTextContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          option.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: option.accentColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          option.subtitle,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            height: 1.3,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildSelectionIndicator() {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? option.accentColor : Colors.transparent,
          border: Border.all(
            color: isSelected ? option.accentColor : Colors.grey.shade400,
            width: 2,
          ),
        ),
      ),
    );
  }
}