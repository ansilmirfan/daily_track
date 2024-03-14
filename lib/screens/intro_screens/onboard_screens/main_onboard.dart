import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:diary_app/screens/intro_screens/get_started.dart';
import 'package:diary_app/screens/intro_screens/onboard_screens/onboard_page.dart';
import 'package:diary_app/varibles_and_functions/functioins.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';

import 'package:flutter/material.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  State<OnBoard> createState() => _OnBoardState();
}

int currentPage = 0;
PageController controller = PageController();

class _OnBoardState extends State<OnBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryCream,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: height * 3 / 4,
                child: PageView(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  controller: controller,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Pages(
                      lottieAsset: 'Assets/lotties/dairy lottie.json',
                      captionText:
                          'Capture your thoughts, dreams, and daily moments with our intuitive diary feature. Your personal space to reflect, remember, and rediscover yourself',
                    ),
                    Pages(
                      captionText:
                          'Stay organized and accomplish more. Plan your day, set goals, and track your progress effortlessly with our powerful to-do list. Turn your aspirations into achievements',
                      lottieAsset: 'Assets/lotties/todo list lottie.json',
                    ),
                    Pages(
                      captionText:
                          'Never miss a moment or deadline. Seamlessly manage your events, appointments, and tasks on our dynamic calendar. Receive timely reminders and stay in control of your schedule',
                      lottieAsset: 'Assets/lotties/calender lottiie.json',
                    ),
                    const GetStarted()
                  ],
                ),
              ),
              Padding(
                padding: paddingXS,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () =>
                          navigatePushReplacement(context, const GetStarted()),
                      child: const Text('Skip'),
                    ),
                    Wrap(
                      spacing: 10,
                      children: List.generate(
                        4,
                        (index) => CircleAvatar(
                          radius: 7,
                          backgroundColor:
                              currentPage == index ? primaryRed : grey,
                        ),
                      ),
                    ),
                    Wrap(
                      children: [
                        TextButton(
                          onPressed: currentPage == 0 ? null : prevPage,
                          child: const Text('Prev'),
                        ),
                        TextButton(
                          onPressed: currentPage == 3 ? null : nextPage,
                          child: const Text('Next'),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void nextPage() {
    controller.animateToPage(
      (controller.page ?? 0).toInt() + 1,
      duration: const Duration(seconds: 1),
      curve: Easing.legacy,
    );
  }

  void prevPage() {
    controller.animateToPage(
      (controller.page ?? 0).toInt() - 1,
      duration: const Duration(seconds: 1),
      curve: Easing.legacy,
    );
  }
}
