import 'package:flutter/material.dart';

class EnergyOption {
  final int index;
  final String title;
  final String subtitle;
  final String imageAsset;
  final Color backgroundColor;
  final Color accentColor;

  const EnergyOption({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    required this.backgroundColor,
    required this.accentColor,
  });

  static const List<EnergyOption> options = [
    EnergyOption(
      index: 0,
      title: 'Energi Rendah',
      subtitle: 'Butuh istirahat dan kegiatan ringan untuk mengisi ulang energi',
      imageAsset: 'assets/images/pilihenergi/energi_rendah.png',
      backgroundColor: Color(0xFFF5F7F4),
      accentColor: Color(0xFF6A9859),
    ),
    EnergyOption(
      index: 1,
      title: 'Energi Sedang',
      subtitle: 'Energi lumayan baik, siap untuk fokus secukupnya',
      imageAsset: 'assets/images/pilihenergi/energi_sedang.png',
      backgroundColor: Color(0xFFE6F0FE),
      accentColor: Color(0xFF2859C5),
    ),
    EnergyOption(
      index: 2,
      title: 'Energi Tinggi',
      subtitle: 'Aku penuh semangat kali ini! Yuk kita selesaikan banyak hal!',
      imageAsset: 'assets/images/pilihenergi/energi_tinggi.png',
      backgroundColor: Color(0xFFEEEAF8),
      accentColor: Color(0xFF8871C6),
    ),
  ];
}