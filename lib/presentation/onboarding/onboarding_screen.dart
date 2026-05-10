import 'package:flutter/material.dart';
import 'onboarding_data.dart';
import 'widgets/onboarding_item.dart';
import 'widgets/dot_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  void nextPage() {
    if (currentIndex < onboardingData.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      print("Masuk App");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            // 🔥 PAGEVIEW
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: onboardingData.length,
                onPageChanged: (index) {
                  setState(() => currentIndex = index);
                },
                itemBuilder: (context, index) {
                  return OnBoardingItem(
                    data: onboardingData[index],
                  );
                },
              ),
            ),

            // 🔘 DOTS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                (index) => DotIndicator(
                  isActive: currentIndex == index,
                ),
              ),
            ),

            const SizedBox(height: 28),

            // 🔥 BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff67C6FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    currentIndex == onboardingData.length - 1
                        ? "Masuk"
                        : "Lanjut",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}