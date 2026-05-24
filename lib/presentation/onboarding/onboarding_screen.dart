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
      // Navigate to Login Page using named route (so BLoC is provided)
      Navigator.pushReplacementNamed(context, '/login');
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

            // 🔥 BUTTON GRADIENT
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                // BUTTON KEMBALI
                if (currentIndex > 0)
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _controller.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      borderRadius: BorderRadius.circular(18),
                      child: Container(
                        height: 58,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Kembali",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                // BUTTON LANJUT / MASUK
                Expanded(
                  child: InkWell(
                    onTap: nextPage,
                    borderRadius: BorderRadius.circular(18),
                    child: Ink(
                      height: 58,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xff4597E6),
                            Color(0xff7BBEFF),
                            Color(0xff83DFC6),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
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