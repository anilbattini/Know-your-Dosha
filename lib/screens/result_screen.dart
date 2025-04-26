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
    final scores = result.doshaScores;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your Dosha Profile',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // Dosha scale bars
              _DoshaBar(
                label: 'Vata',
                value: scores['vata'] ?? 0,
                color: AppColors.vata,
                icon: Icons.air,
              ),
              _DoshaBar(
                label: 'Pitta',
                value: scores['pitta'] ?? 0,
                color: AppColors.pitta,
                icon: Icons.local_fire_department,
              ),
              _DoshaBar(
                label: 'Kapha',
                value: scores['kapha'] ?? 0,
                color: AppColors.kapha,
                icon: Icons.water_drop,
              ),
              const SizedBox(height: 24),
              if (dosha != null) ...[
                CircleAvatar(
                  radius: 48,
                  backgroundColor: getDoshaColor(dosha),
                  child: Text(
                    getDoshaName(dosha),
                    style: const TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  getDoshaDescription(dosha),
                  style: TextStyle(fontSize: 18, color: AppColors.textSecondary),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                // Suggestions section
                Text(
                  'Personalized Suggestions',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 12),
                _DoshaSuggestions(dosha: dosha),
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

// Dosha scale bar widget
class _DoshaBar extends StatelessWidget {
  final String label;
  final int value;
  final Color color;
  final IconData icon;
  const _DoshaBar({required this.label, required this.value, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 8),
          SizedBox(
            width: 60,
            child: Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
          ),
          Expanded(
            child: LinearProgressIndicator(
              value: value / 30.0, // assuming max 30 questions
              color: color,
              backgroundColor: color.withOpacity(0.15),
              minHeight: 12,
            ),
          ),
          const SizedBox(width: 8),
          Text('$value', style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// Suggestions widget (food, lifestyle, etc.)
class _DoshaSuggestions extends StatelessWidget {
  final String dosha;
  const _DoshaSuggestions({required this.dosha});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with structured data and images for each dosha
    switch (dosha) {
      case 'vata':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SuggestionTile(
              image: 'assets/vata_foods.png',
              title: 'Best Foods',
              description: 'Warm, moist, oily foods. Favor cooked grains, root vegetables, dairy, nuts, and healthy oils. Avoid dry, cold, and raw foods.',
            ),
            _SuggestionTile(
              image: 'assets/vata_lifestyle.png',
              title: 'Lifestyle',
              description: 'Keep a regular routine, stay warm, practice gentle yoga, and get enough rest. Avoid overstimulation and excessive travel.',
            ),
          ],
        );
      case 'pitta':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SuggestionTile(
              image: 'assets/pitta_foods.png',
              title: 'Best Foods',
              description: 'Cool, refreshing foods. Favor sweet fruits, leafy greens, dairy, and grains. Avoid spicy, oily, and fried foods.',
            ),
            _SuggestionTile(
              image: 'assets/pitta_lifestyle.png',
              title: 'Lifestyle',
              description: 'Stay cool, avoid excessive heat, practice calming activities, and spend time in nature. Avoid overworking and conflict.',
            ),
          ],
        );
      case 'kapha':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SuggestionTile(
              image: 'assets/kapha_foods.png',
              title: 'Best Foods',
              description: 'Light, dry, and spicy foods. Favor legumes, bitter greens, and spices. Avoid heavy, oily, and sweet foods.',
            ),
            _SuggestionTile(
              image: 'assets/kapha_lifestyle.png',
              title: 'Lifestyle',
              description: 'Stay active, try invigorating exercise, and keep a varied routine. Avoid oversleeping and excessive snacking.',
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class _SuggestionTile extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  const _SuggestionTile({required this.image, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: AppColors.card,
      child: ListTile(
        leading: Image.asset(image, width: 48, height: 48, fit: BoxFit.cover),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
        subtitle: Text(description, style: TextStyle(color: AppColors.textSecondary)),
      ),
    );
  }
} 