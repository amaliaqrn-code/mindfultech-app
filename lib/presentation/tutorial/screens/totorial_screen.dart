import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../data/tutorial_data.dart';
import '../widgets/dot_indicator.dart';
import '../widgets/tutorial_button.dart';
import '../widgets/tutorial_page.dart';
import '../../homepage/homepage_screen.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final PageController _controller = PageController();

  int currentIndex = 0;

  void nextPage() {
    if (currentIndex < tutorialData.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to Homepage
      _navigateToHomepage();
    }
  }

  void _navigateToHomepage() {
    // Mark onboarding as completed
    final storage = GetStorage();
    storage.write('hasOnboarded', true);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomepageScreen(),
      ),
    );
  }

  void previousPage() {
    _controller.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: tutorialData.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return TutorialPage(
                    data: tutorialData[index],
                    index: index,
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                tutorialData.length,
                (index) => DotIndicator(
                  isActive: currentIndex == index,
                ),
              ),
            ),

            const SizedBox(height: 28),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  if (currentIndex > 0)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: TutorialButton(
                          text: "Kembali",
                          isWhite: true,
                          onTap: previousPage,
                        ),
                      ),
                    ),

                  Expanded(
                    child: TutorialButton(
                      text: currentIndex == tutorialData.length - 1
                          ? "Masuk"
                          : "Lanjut",
                      onTap: nextPage,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}