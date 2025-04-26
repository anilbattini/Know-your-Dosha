import 'package:flutter_test/flutter_test.dart';
import 'package:dosha_quiz_app/core/food_suggestions.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  group('Food Suggestions Tests', () {
    setUpAll(() async {
      // Load food suggestions before running tests
      await FoodSuggestionsLoader.loadFoodSuggestions();
    });

    test('should have foods to favor for all doshas', () {
      for (String dosha in ['vata', 'pitta', 'kapha']) {
        final favorFoods = FoodSuggestionsLoader.getFoodsByDosha(dosha, minRating: 4);

        expect(
          favorFoods.isNotEmpty,
          true,
          reason: 'Should have foods to favor for $dosha dosha',
        );
      }
    });

    test('should have foods to avoid for all doshas', () {
      for (String dosha in ['vata', 'pitta', 'kapha']) {
        final avoidFoods = FoodSuggestionsLoader.getFoodsToAvoid(dosha, maxRating: 2);

        expect(
          avoidFoods.isNotEmpty,
          true,
          reason: 'Should have foods to avoid for $dosha dosha',
        );
      }
    });

    test('should have image assets for all foods', () {
      final foods = FoodSuggestionsLoader.getFoodSuggestions();
      for (FoodSuggestion food in foods) {
        expect(
          food.imageAsset,
          isNotNull,
          reason: 'Food ${food.name} should have an image asset',
        );
        expect(
          food.imageAsset!.startsWith('assets/foods/'),
          true,
          reason:
              'Food ${food.name} image should be in assets/foods/ directory',
        );
      }
    });

    test('should have valid dosha ratings for all foods', () {
      final foods = FoodSuggestionsLoader.getFoodSuggestions();
      for (FoodSuggestion food in foods) {
        expect(food.doshaRatings.containsKey('vata'), true);
        expect(food.doshaRatings.containsKey('pitta'), true);
        expect(food.doshaRatings.containsKey('kapha'), true);

        for (int rating in food.doshaRatings.values) {
          expect(
            rating >= 1 && rating <= 5,
            true,
            reason: 'Rating should be between 1 and 5 for ${food.name}',
          );
        }
      }
    });
  });
}
