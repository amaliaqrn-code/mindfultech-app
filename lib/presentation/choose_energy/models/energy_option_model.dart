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
      subtitle: 'Butuh istirahat dan kegiatan ringan untuk mengisi ulang',
      imageAsset: 'assets/images/pilihenergi/energi_rendah.png',
      backgroundColor: Color(0xFFE8F5E9),
      accentColor: Color(0xFF6A9859),
    ),
    EnergyOption(
      index: 1,
      title: 'Energi Sedang',
      subtitle: 'Energi lumayan baik, siap untuk fokus secukupnya',
      imageAsset: 'assets/images/pilihenergi/energi_sedang.png',
      backgroundColor: Color(0xFFE3F2FD),
      accentColor: Color(0xFF4597E6),
    ),
    EnergyOption(
      index: 2,
      title: 'Energi Tinggi',
      subtitle: 'Aku penuh semangat kali ini! Yuk kita selesaikan banyak hal!',
      imageAsset: 'assets/images/pilihenergi/energi_tinggi.png',
      backgroundColor: Color(0xFFEDE7F6),
      accentColor: Color(0xFF8E6DC9),
    ),
  ];
}