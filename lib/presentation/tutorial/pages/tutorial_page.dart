import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mindfultech_app/core/routes/app_routes.dart';
import '../data/tutorial_data.dart';
import '../widgets/dot_indicator.dart';
import '../widgets/tutorial_button.dart';
import '../widgets/tutorial_page.dart';
import '../widgets/energy_tutorial_page.dart';
import '../widgets/task_tutorial_page.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key});

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  void _nextPage() {
    if (_currentIndex < tutorialData.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToHomepage();
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _navigateToHomepage() {
    final storage = GetStorage();
    storage.write('hasOnboarded', true);

    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homepage, (route) => false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FAFF),
      body: SafeArea(
        child: Column(
          children: [
            // ================= MAIN CONTENT =================
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: tutorialData.length,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  // Page 0: Energy Tutorial
                  if (index == 0) {
                    return EnergyTutorialPage(
                      data: tutorialData[index],
                    );
                  }
                  // Page 1: Task Tutorial
                  if (index == 1) {
                    return TaskTutorialPage(
                      data: tutorialData[index],
                    );
                  }
                  // Pages 2-3: Default Tutorial Pages
                  return TutorialContent(
                    data: tutorialData[index],
                    index: index,
                  );
                },
              ),
            ),

            // ================= DOT INDICATOR =================
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  tutorialData.length,
                  (index) => DotIndicator(isActive: _currentIndex == index),
                ),
              ),
            ),

            // ================= NAVIGATION BUTTONS =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  // Back Button
                  if (_currentIndex > 0)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: TutorialButton(
                          text: "Kembali",
                          isGradient: false,
                          isOutline: true,
                          onTap: _previousPage,
                        ),
                      ),
                    ),

                  // Next/Enter Button
                  Expanded(
                    child: TutorialButton(
                      text: _currentIndex == tutorialData.length - 1
                          ? "Masuk"
                          : "Lanjut",
                      isGradient: true,
                      onTap: _nextPage,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}