import 'package:flutter/material.dart';

class OnboardingContent {
  String image;
  String title;
  String discription;
  Color backgroundColor;
  OnboardingContent({
    required this.image,
    required this.title,
    required this.discription,
    required this.backgroundColor,
  });
}

// Created By Flutter Baba
List<OnboardingContent> contentsList = [
  OnboardingContent(
    backgroundColor: const Color(0xff95B6FF),
    title: 'Walking',
    image: 'lib/images/onboarding/p5.jpg',
    discription:
        "Walking is a simple and accessible exercise that involves moving at a moderate pace by putting one foot in front of the other. It promotes cardiovascular health a health and enhances overall fitness.",
  ),
  OnboardingContent(
    backgroundColor: Color.fromARGB(255, 226, 195, 103),
    title: 'Illustration',
    image: 'lib/images/onboarding/p4.jpg',
    discription:
        "Illustrations with dumbbells as exercise involve using these weights in various movements to target specific muscle groups. Whether it's lifting, curling, or pressing, dumbbells allow for wide range exercises",
  ),
  OnboardingContent(
    backgroundColor: const Color(0xffB7ABFD),
    title: 'Yoga',
    image: 'lib/images/onboarding/p2.jpg',
    discription:
        "Yoga is a centuries-old practice that combines physical postures, breathing techniques, and meditation to enhance flexibility, strength, and mental well-being. It promotes relaxation, inner peace.",
  ),
  OnboardingContent(
    backgroundColor: const Color(0xffEFB491),
    title: 'Runnig',
    image: 'lib/images/onboarding/p3.jpg',
    discription:
        "Running is a simple yet effective exercise that involves moving on swiftly foot. It boosts cardiovascular fitness, burns calories, and leg muscles. Running 45 minues per day help you to maintain good health.",
  ),
];
