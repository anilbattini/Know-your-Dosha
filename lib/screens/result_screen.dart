import 'package:flutter/material.dart';
import '../core/color_palette.dart';
import '../core/quiz_logic.dart';
import 'welcome_screen.dart';

class ResultScreen extends StatelessWidget {
  final QuizResult result;
  const ResultScreen({super.key, required this.result});

  String getDoshaName(String dosha) {
    switch (dosha) {
      case 'vata':
        return 'Vata';
      case 'pitta':
        return 'Pitta';
      case 'kapha':
        return 'Kapha';
      default:
        return '';
    }
  }

  String getDoshaDescription(String dosha) {
    switch (dosha) {
      case 'vata':
        return 'Vata is associated with air and space. People with dominant Vata are energetic, creative, and lively, but may experience anxiety and dryness.';
      case 'pitta':
        return 'Pitta is associated with fire and water. Pitta types are passionate, intelligent, and driven, but may be prone to irritability and overheating.';
      case 'kapha':
        return 'Kapha is associated with earth and water. Kapha types are calm, steady, and nurturing, but may struggle with sluggishness and weight gain.';
      default:
        return '';
    }
  }

  Color getDoshaColor(String dosha) {
    switch (dosha) {
      case 'vata':
        return AppColors.vata;
      case 'pitta':
        return AppColors.pitta;
      case 'kapha':
        return AppColors.kapha;
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dosha = result.dominantDosha;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your Dominant Dosha',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              if (dosha != null) ...[
                CircleAvatar(
                  radius: 48,
                  backgroundColor: getDoshaColor(dosha),
                  child: Text(
                    getDoshaName(dosha),
                    style: const TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  getDoshaDescription(dosha),
                  style: TextStyle(fontSize: 18, color: AppColors.textSecondary),
                  textAlign: TextAlign.center,
                ),
              ] else ...[
                Text(
                  'Result is ambiguous. Please try again for a clearer result.',
                  style: TextStyle(fontSize: 18, color: AppColors.textSecondary),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                    (route) => false,
                  );
                },
                child: const Text(
                  'Retake Quiz',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 