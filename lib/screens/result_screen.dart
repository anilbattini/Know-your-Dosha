import 'package:flutter/material.dart';
import '../core/color_palette.dart';
import '../core/quiz_logic.dart';
import 'welcome_screen.dart';
import '../core/food_suggestions.dart';
import 'package:flutter/foundation.dart'; // Added for kTransparentImage
import '../core/app_style.dart'; // Added for AppStyle
import 'dart:typed_data';

// Transparent image data
final Uint8List kTransparentImage = Uint8List.fromList([
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
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
                    style: const TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  getDoshaDescription(dosha),
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                // Suggestions section
                Text(
                  'Personalized Suggestions',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                _DoshaSuggestions(dosha: dosha),
              ] else ...[
                Text(
                  'Result is ambiguous. Please try again for a clearer result.',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WelcomeScreen(),
                    ),
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
  const _DoshaBar({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

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
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, color: color),
            ),
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
          Text(
            '$value',
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FoodCard(dosha: dosha),
        const SizedBox(height: 20),
        Text('Lifestyle', style: AppStyle.title.copyWith(fontSize: 20)),
        const SizedBox(height: 8),
        _LifestyleSuggestion(dosha: dosha),
      ],
    );
  }
}

class _FoodCard extends StatelessWidget {
  final String dosha;
  const _FoodCard({required this.dosha});

  @override
  Widget build(BuildContext context) {
    // Get recommended foods for this dosha (rating >= 4)
    final recommendedFoods = FoodSuggestionsLoader.getFoodsByDosha(dosha, minRating: 4);

    // Get foods to avoid for this dosha (rating <= 2)
    final avoidFoods = FoodSuggestionsLoader.getFoodsToAvoid(dosha, maxRating: 2);

    // Shuffle to show variety and take first 6 items
    recommendedFoods.shuffle();
    avoidFoods.shuffle();

    final displayRecommended = recommendedFoods.take(6).toList();
    final displayAvoid = avoidFoods.take(6).toList();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recommended Foods Section
            Text(
              'Foods to Favor',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: _getDoshaColor(dosha),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildFoodGrid(displayRecommended, context),

            const SizedBox(height: 16),

            // Foods to Avoid Section
            Text(
              'Foods to Reduce',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.red[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildFoodGrid(displayAvoid, context, isAvoid: true),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodGrid(
    List<FoodSuggestion> foods,
    BuildContext context, {
    bool isAvoid = false,
  }) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.9,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: foods.length,
      itemBuilder: (context, index) {
        return _buildFoodItem(context, foods[index], isAvoid: isAvoid);
      },
    );
  }

  Widget _buildFoodItem(
    BuildContext context,
    FoodSuggestion food, {
    bool isAvoid = false,
  }) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  food.imageAsset ?? 'assets/foods/fallback.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.fastfood,
                        size: 30,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
              if (isAvoid)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.not_interested,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          food.name.split(' ')[0],
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: isAvoid ? Colors.red[700] : null,
            fontWeight: isAvoid ? FontWeight.bold : null,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Color _getDoshaColor(String dosha) {
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
}

class _LifestyleSuggestion extends StatelessWidget {
  final String dosha;
  const _LifestyleSuggestion({required this.dosha});

  @override
  Widget build(BuildContext context) {
    final tips = _getLifestyleTips(dosha);
    final imagePath = _getLifestyleImage(dosha);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image on the left
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Text content on the right
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lifestyle Tips',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: _getDoshaColor(dosha),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...tips
                      .map(
                        (tip) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: _getDoshaColor(dosha),
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  tip,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.copyWith(height: 1.4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      ,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getLifestyleImage(String dosha) {
    switch (dosha) {
      case 'vata':
        return 'assets/vata_lifestyle.png';
      case 'pitta':
        return 'assets/pitta_lifestyle.png';
      case 'kapha':
        return 'assets/kapha_lifestyle.png';
      default:
        return 'assets/vata_lifestyle.png';
    }
  }

  List<String> _getLifestyleTips(String dosha) {
    switch (dosha) {
      case 'vata':
        return [
          'Maintain a regular daily routine with consistent meal and sleep times.',
          'Engage in gentle, grounding exercises like yoga, tai chi, or walking in nature.',
          'Keep warm in cold weather and avoid cold, dry foods and drinks.',
          'Practice meditation and deep breathing to calm the mind.',
        ];
      case 'pitta':
        return [
          'Stay cool in hot weather and avoid excessive heat or sun exposure.',
          'Practice relaxation techniques like meditation and deep breathing exercises.',
          'Engage in non-competitive physical activities and avoid overworking.',
          'Maintain a balanced diet with cooling foods and avoid spicy foods.',
        ];
      case 'kapha':
        return [
          'Stay active with regular, vigorous exercise to maintain energy levels.',
          'Keep a varied routine and try new activities to stay stimulated.',
          'Wake up early and avoid daytime napping to maintain energy balance.',
          'Include warming spices in your diet and avoid heavy, oily foods.',
        ];
      default:
        return [];
    }
  }

  Color _getDoshaColor(String dosha) {
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
}

class _SuggestionTile extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  const _SuggestionTile({
    required this.image,
    required this.title,
    required this.description,
  });

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
            return Image.asset(
              'assets/foods/fallback.png',
              width: 56,
              height: 56,
              fit: BoxFit.cover,
            );
          },
        ),
        title: Text(title, style: AppStyle.title.copyWith(fontSize: 18)),
        subtitle: Text(
          description,
          style: AppStyle.subtitle.copyWith(fontSize: 14),
        ),
      ),
    );
  }
}
