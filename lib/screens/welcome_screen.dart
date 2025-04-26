import 'package:flutter/material.dart';
import '../core/color_palette.dart';
import '../core/app_style.dart';
import 'quiz_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _titleTapCount = 0;
  bool _adminMode = false;

  void _onTitleTap() {
    setState(() {
      _titleTapCount++;
      if (_titleTapCount >= 5) {
        _adminMode = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _onTitleTap,
                child: Text(
                  'Discover Your Dominant Dosha',
                  style: AppStyle.headline,
                  textAlign: TextAlign.center,
                ),
              ),
              if (_adminMode)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Admin Mode Enabled',
                    style: AppStyle.subtitle.copyWith(color: AppColors.pitta, fontWeight: FontWeight.bold),
                  ),
                ),
              const SizedBox(height: 24),
              Text(
                'Take this quiz to find out if Vata, Pitta, or Kapha is most dominant in your body. Answer honestly for best results.',
                style: AppStyle.body.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: AppStyle.elevatedButton,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuizScreen(adminMode: _adminMode)),
                  );
                },
                child: const Text(
                  'Start Quiz',
                  style: AppStyle.title,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 