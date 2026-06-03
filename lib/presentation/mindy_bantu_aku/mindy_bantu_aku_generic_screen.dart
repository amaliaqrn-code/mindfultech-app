import 'package:flutter/material.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import 'package:mindfultech_app/presentation/mindy_bantu_aku/models/mindy_theme.dart';

/// Screen generik untuk Mindy Bantu Aku dengan berbagai tema
/// Bisa digunakan untuk Green, Blue, dan Purple theme
class MindyBantuAkuGenericScreen extends StatefulWidget {
  final EnergyLevel energyLevel;

  const MindyBantuAkuGenericScreen({
    super.key,
    required this.energyLevel,
  });

  @override
  State<MindyBantuAkuGenericScreen> createState() => _MindyBantuAkuGenericScreenState();
}

class _MindyBantuAkuGenericScreenState extends State<MindyBantuAkuGenericScreen> {
  // Step: 0 = category, 1 = task
  int _currentStep = 0;
  int _selectedCategoryIndex = -1;
  int _selectedTaskIndex = -1;

  // Task data per kategori (bisa di-custom per energi)
  Map<String, List<MindyTask>> get _tasksByCategory => _getTasksForEnergy(widget.energyLevel);

  Map<String, List<MindyTask>> _getTasksForEnergy(EnergyLevel energy) {
    final tasks = <String, List<MindyTask>>{};

    for (final category in MindyCategory.categories) {
      tasks[category.name] = _getTasksForCategory(category.name, energy);
    }

    return tasks;
  }

  List<MindyTask> _getTasksForCategory(String categoryName, EnergyLevel energy) {
    switch (categoryName) {
      case 'Belajar':
        if (energy == EnergyLevel.low) {
          return [
            MindyTask(title: 'Baca buku 5 menit', duration: '5 menit', category: 'Belajar', color: widget.energyLevel.theme.primaryColor),
          ];
        } else if (energy == EnergyLevel.medium) {
          return [
            MindyTask(title: 'Belajar UI/UX dasar', duration: '2 jam', category: 'Belajar', color: widget.energyLevel.theme.primaryColor),
          ];
        } else {
          return [
            MindyTask(title: 'Belajar coding dasar', duration: '3 jam', category: 'Belajar', color: widget.energyLevel.theme.primaryColor),
          ];
        }
      case 'Pekerjaan':
        if (energy == EnergyLevel.low) {
          return [
            MindyTask(title: 'Baca email', duration: '10 menit', category: 'Kerja', color: widget.energyLevel.theme.primaryColor),
          ];
        } else if (energy == EnergyLevel.medium) {
          return [
            MindyTask(title: 'Baca email klien', duration: '1 jam', category: 'Kerja', color: widget.energyLevel.theme.primaryColor),
          ];
        } else {
          return [
            MindyTask(title: 'Bahas email klien', duration: '2 jam', category: 'Kerja', color: widget.energyLevel.theme.primaryColor),
          ];
        }
      default:
        return [
          MindyTask(title: 'Task default', duration: '30 menit', category: categoryName, color: widget.energyLevel.theme.primaryColor),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.energyLevel.theme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(theme),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    if (_currentStep == 0) ...[
                      _buildMascotSection(theme),
                      const SizedBox(height: 24),
                      _buildCategoryGrid(theme),
                    ] else ...[
                      _buildTaskList(theme),
                    ],
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            _buildBottomButton(theme),
          ],
        ),
      ),
      bottomNavigationBar: theme.showBottomNav ? _buildBottomNav(theme) : null,
    );
  }

  Widget _buildHeader(MindyTheme theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (_currentStep == 1) {
                setState(() {
                  _currentStep = 0;
                  _selectedTaskIndex = -1;
                });
              } else {
                Navigator.pop(context);
              }
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.primaryColor.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: theme.primaryColor,
                size: 16,
              ),
            ),
          ),
          const Spacer(),
          // Progress indicator
          Row(
            children: [
              _buildProgressDot(isActive: true, theme: theme),
              const SizedBox(width: 8),
              _buildProgressDot(isActive: _currentStep >= 1, theme: theme),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressDot({required bool isActive, required MindyTheme theme}) {
    return Container(
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: isActive ? theme.primaryColor : Colors.grey.shade300,
      ),
    );
  }

  Widget _buildMascotSection(MindyTheme theme) {
    return SizedBox(
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Decorations berdasarkan energi
          ..._buildDecorations(theme),
          // Main mascot
          _buildMascot(theme),
        ],
      ),
    );
  }

  List<Widget> _buildDecorations(MindyTheme theme) {
    switch (widget.energyLevel) {
      case EnergyLevel.low:
        // Daun-daun untuk energi rendah
        return [
          Positioned(
            left: 20,
            top: 30,
            child: Transform.rotate(
              angle: -0.4,
              child: Image.asset(
                'assets/images/tutorial/daun.png',
                width: 28,
                height: 28,
                color: theme.primaryColor.withValues(alpha: 0.5),
                errorBuilder: (_, __, ___) => Icon(Icons.eco_rounded, size: 28, color: theme.primaryColor.withValues(alpha: 0.5)),
              ),
            ),
          ),
          Positioned(
            right: 30,
            top: 20,
            child: Transform.rotate(
              angle: 0.3,
              child: Image.asset(
                'assets/images/tutorial/daun.png',
                width: 22,
                height: 22,
                color: theme.primaryColor.withValues(alpha: 0.4),
                errorBuilder: (_, __, ___) => Icon(Icons.eco_rounded, size: 22, color: theme.primaryColor.withValues(alpha: 0.4)),
              ),
            ),
          ),
        ];
      case EnergyLevel.medium:
        // Bintang-bintang untuk energi sedang
        return [
          Positioned(
            left: 25,
            top: 35,
            child: Icon(Icons.star_rounded, color: theme.primaryColor.withValues(alpha: 0.25), size: 24),
          ),
          Positioned(
            right: 35,
            top: 25,
            child: Icon(Icons.star_rounded, color: theme.primaryColor.withValues(alpha: 0.2), size: 18),
          ),
          Positioned(
            right: 15,
            top: 65,
            child: Icon(Icons.star_rounded, color: theme.primaryColor.withValues(alpha: 0.15), size: 14),
          ),
        ];
      case EnergyLevel.high:
        // Petir untuk energi tinggi
        return [
          Positioned(
            left: 30,
            top: 35,
            child: Icon(Icons.bolt_rounded, color: theme.secondaryColor.withValues(alpha: 0.4), size: 26),
          ),
          Positioned(
            right: 25,
            top: 25,
            child: Icon(Icons.bolt_rounded, color: theme.primaryColor.withValues(alpha: 0.3), size: 20),
          ),
          Positioned(
            left: 15,
            top: 65,
            child: Icon(Icons.bolt_rounded, color: theme.secondaryColor.withValues(alpha: 0.25), size: 16),
          ),
        ];
    }
  }

  Widget _buildMascot(MindyTheme theme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Mascot image
        Image.asset(
          theme.mascotAsset,
          width: 140,
          height: 120,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => Container(
            width: 120,
            height: 90,
            decoration: BoxDecoration(
              color: theme.cardBg,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: theme.primaryColor.withValues(alpha: 0.15),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Center(
              child: Text(_getMascotEmoji(), style: const TextStyle(fontSize: 40)),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Title dengan gradient sesuai tema
        _buildTitle(theme),
        const SizedBox(height: 4),
        // Subtitle
        Text(
          'Pilih kategori agar Mindy bisa\nmembantumu memilih cara terbaik',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: theme.subtitleColor,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(MindyTheme theme) {
    final text = 'Mau fokus kategori apa?';

    if (widget.energyLevel == EnergyLevel.medium || widget.energyLevel == EnergyLevel.high) {
      return ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [theme.primaryColor, theme.secondaryColor],
        ).createShader(bounds),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    }

    return Text(
      text,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: theme.primaryColor,
      ),
    );
  }

  String _getMascotEmoji() {
    switch (widget.energyLevel) {
      case EnergyLevel.low: return '😴';
      case EnergyLevel.medium: return '😊';
      case EnergyLevel.high: return '⚡';
    }
  }

  Widget _buildCategoryGrid(MindyTheme theme) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 0.88,
      ),
      itemCount: MindyCategory.categories.length,
      itemBuilder: (context, index) {
        final category = MindyCategory.categories[index];
        final isSelected = _selectedCategoryIndex == index;
        return _buildCategoryCard(category, isSelected, theme);
      },
    );
  }

  Widget _buildCategoryCard(MindyCategory category, bool isSelected, MindyTheme theme) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryIndex = MindyCategory.categories.indexOf(category);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : theme.cardBg,
          borderRadius: BorderRadius.circular(18),
          border: isSelected ? Border.all(color: theme.primaryColor, width: 1.5) : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: theme.primaryColor.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                category.imagePath,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(category.fallbackIcon, color: theme.primaryColor, size: 24),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              category.name,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? theme.primaryColor : theme.primaryColor.withValues(alpha: 0.8),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// ============ STEP 2: TASK LIST ============

  Widget _buildTaskList(MindyTheme theme) {
    final selectedCategory = MindyCategory.categories[_selectedCategoryIndex];
    final tasks = _tasksByCategory[selectedCategory.name] ?? [];

    return Column(
      children: [
        // Mindy mascot di kanan
        SizedBox(
          height: 100,
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              Image.asset(
                theme.mascotAsset,
                width: 90,
                height: 80,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Container(
                  width: 80,
                  height: 70,
                  decoration: BoxDecoration(color: theme.cardBg, borderRadius: BorderRadius.circular(32)),
                  child: Center(child: Text(_getMascotEmoji(), style: const TextStyle(fontSize: 30))),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Title
        _buildTaskTitle(theme),
        const SizedBox(height: 4),
        Text(
          'Pilih task yang ingin kamu kerjakan',
          style: TextStyle(fontSize: 13, color: theme.subtitleColor),
        ),
        const SizedBox(height: 20),
        // Task cards
        ...List.generate(tasks.length, (index) {
          final task = tasks[index];
          return _buildTaskCard(task, index, theme);
        }),
        const SizedBox(height: 16),
        // "Coba yang lain" button
        _buildTryOtherButton(theme),
      ],
    );
  }

  Widget _buildTaskTitle(MindyTheme theme) {
    final text = 'Task yang cocok untukmu';

    if (widget.energyLevel == EnergyLevel.medium || widget.energyLevel == EnergyLevel.high) {
      return ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [theme.primaryColor, theme.secondaryColor],
        ).createShader(bounds),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    }

    return Text(
      text,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: theme.primaryColor,
      ),
    );
  }

  Widget _buildTaskCard(MindyTask task, int index, MindyTheme theme) {
    final isSelected = _selectedTaskIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTaskIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : theme.cardBg,
          borderRadius: BorderRadius.circular(18),
          border: isSelected ? Border.all(color: theme.primaryColor, width: 1.5) : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: theme.primaryColor.withValues(alpha: 0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            // Task icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: task.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                _getCategoryIcon(task.category),
                color: task.color,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            // Task info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.timer_outlined, size: 14, color: theme.subtitleColor),
                      const SizedBox(width: 4),
                      Text(
                        task.duration,
                        style: TextStyle(fontSize: 12, color: theme.subtitleColor),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: task.color.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          task.category,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: task.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Star icon
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [theme.primaryColor, theme.secondaryColor],
                ),
              ),
              child: const Icon(Icons.star, color: Colors.white, size: 16),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Belajar': return Icons.menu_book_rounded;
      case 'Kerja':
      case 'Pekerjaan': return Icons.work_rounded;
      case 'Kesehatan': return Icons.favorite_rounded;
      case 'Pribadi': return Icons.person_rounded;
      case 'Rumah': return Icons.home_rounded;
      default: return Icons.auto_awesome_rounded;
    }
  }

  Widget _buildTryOtherButton(MindyTheme theme) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTaskIndex = -1;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: theme.cardBg,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.refresh_rounded, color: theme.primaryColor, size: 18),
            const SizedBox(width: 8),
            Text(
              'Coba yang lain',
              style: TextStyle(
                color: theme.primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton(MindyTheme theme) {
    final bool canProceed = (_currentStep == 0)
        ? (_selectedCategoryIndex >= 0)
        : (_selectedTaskIndex >= 0);

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).padding.bottom + (theme.showBottomNav ? 60 : 20),
      ),
      child: GestureDetector(
        onTap: canProceed
            ? () {
                if (_currentStep == 0) {
                  setState(() {
                    _currentStep = 1;
                    _selectedTaskIndex = -1;
                  });
                } else {
                  Navigator.pushNamed(context, AppRoutes.timer);
                }
              }
            : null,
        child: Container(
          width: double.infinity,
          height: 54,
          decoration: BoxDecoration(
            gradient: theme.buttonGradient,
            color: theme.buttonGradient == null ? theme.primaryColor : null,
            borderRadius: BorderRadius.circular(100),
            boxShadow: canProceed
                ? [
                    BoxShadow(
                      color: theme.primaryColor.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (theme.hasButtonIcon) ...[
                  Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                ],
                Text(
                  _currentStep == 0 ? 'Lanjut' : 'Yuk, mulai fokus!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav(MindyTheme theme) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(icon: Icons.home_rounded, label: 'Home', isActive: false, theme: theme),
              _buildNavItem(icon: Icons.explore_rounded, label: 'Journey', isActive: true, theme: theme),
              _buildNavItem(icon: Icons.settings_rounded, label: 'Settings', isActive: false, theme: theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required MindyTheme theme,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? theme.primaryColor : Colors.grey.shade400,
            size: 26,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              color: isActive ? theme.primaryColor : Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}