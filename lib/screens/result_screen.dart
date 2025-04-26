import 'package:flutter/material.dart';
import '../core/color_palette.dart';
import '../core/quiz_logic.dart';
import 'welcome_screen.dart';
import '../core/food_suggestions.dart';
import 'package:flutter/foundation.dart'; // Added for kTransparentImage
import '../core/app_style.dart'; // Added for AppStyle
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';

// Transparent image data
final Uint8List kTransparentImage = Uint8List.fromList([
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52,
  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4,
  0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE,
]);

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
    // Group foods by type
    final groupedFoods = <String, List<FoodSuggestion>>{};
    for (final food in foodSuggestions) {
      if (!groupedFoods.containsKey(food.type)) {
        groupedFoods[food.type] = [];
      }
      if (food.doshaRatings[dosha] != null && food.doshaRatings[dosha]! >= 4) {
        groupedFoods[food.type]!.add(food);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...groupedFoods.entries.map((entry) {
          if (entry.value.isEmpty) return const SizedBox.shrink();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  '${entry.key[0].toUpperCase()}${entry.key.substring(1)}',
                  style: AppStyle.title.copyWith(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 110,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: entry.value.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, i) {
                    final food = entry.value[i];
                    return _FoodCard(food: food, dosha: dosha);
                  },
                ),
              ),
            ],
          );
        }),
        const SizedBox(height: 20),
        Text('Lifestyle', style: AppStyle.title.copyWith(fontSize: 20)),
        const SizedBox(height: 8),
        _LifestyleSuggestion(dosha: dosha),
      ],
    );
  }
}

class _FoodCard extends StatelessWidget {
  final FoodSuggestion food;
  final String dosha;
  const _FoodCard({required this.food, required this.dosha});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.card,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (food.imageAsset != null)
              FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage(food.imageAsset!),
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/foods/fallback.png', width: 48, height: 48, fit: BoxFit.cover);
                },
              )
            else
              Image.asset('assets/foods/fallback.png', width: 48, height: 48, fit: BoxFit.cover),
            const SizedBox(height: 4),
            Text(food.name, textAlign: TextAlign.center, style: AppStyle.subtitle.copyWith(fontSize: 13, fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (i) => Icon(
                Icons.star,
                size: 10,
                color: i < (food.doshaRatings[dosha] ?? 0) ? AppColors.accent : AppColors.card.withOpacity(0.5),
              )),
            ),
          ],
        ),
      ),
    );
  }
}

class _LifestyleSuggestion extends StatelessWidget {
  final String dosha;
  const _LifestyleSuggestion({required this.dosha});

  @override
  Widget build(BuildContext context) {
    String imagePath = '';
    String title = '';
    String description = '';
    switch (dosha) {
      case 'vata':
        imagePath = 'assets/vata_lifestyle.png';
        title = 'Vata Lifestyle';
        description = 'Keep a regular routine, stay warm, practice gentle yoga, and get enough rest. Avoid overstimulation and excessive travel.';
        break;
      case 'pitta':
        imagePath = 'assets/pitta_lifestyle.png';
        title = 'Pitta Lifestyle';
        description = 'Stay cool, avoid excessive heat, practice calming activities, and spend time in nature. Avoid overworking and conflict.';
        break;
      case 'kapha':
        imagePath = 'assets/kapha_lifestyle.png';
        title = 'Kapha Lifestyle';
        description = 'Stay active, try invigorating exercise, and keep a varied routine. Avoid oversleeping and excessive snacking.';
        break;
      default:
        return const SizedBox.shrink();
    }
    return _SuggestionTile(
      image: imagePath,
      title: title,
      description: description,
    );
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
      color: AppColors.card,
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        leading: FadeInImage(
          placeholder: MemoryImage(kTransparentImage),
          image: AssetImage(image),
          width: 56,
          height: 56,
          fit: BoxFit.cover,
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset('assets/foods/fallback.png', width: 56, height: 56, fit: BoxFit.cover);
          },
        ),
        title: Text(title, style: AppStyle.title.copyWith(fontSize: 18)),
        subtitle: Text(description, style: AppStyle.subtitle.copyWith(fontSize: 14)),
      ),
    );
  }
} 