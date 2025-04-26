import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

class FoodSuggestion {
  final String name;
  final String
  type; // e.g., 'grain', 'fruit', 'oil', 'vegetable', 'spice', etc.
  final Map<String, int>
  doshaRatings; // e.g., {'vata': 5, 'pitta': 2, 'kapha': 1}
  final String? imageAsset;

  const FoodSuggestion({
    required this.name,
    required this.type,
    required this.doshaRatings,
    this.imageAsset,
  });

  // Factory constructor to create from JSON
  factory FoodSuggestion.fromJson(Map<String, dynamic> json) {
    return FoodSuggestion(
      name: json['name'] as String,
      type: json['type'] as String,
      doshaRatings: Map<String, int>.from(json['doshaRatings'] as Map),
      imageAsset: json['imageAsset'] as String?,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'doshaRatings': doshaRatings,
      'imageAsset': imageAsset,
    };
  }
}

class FoodSuggestionsLoader {
  static List<FoodSuggestion>? _cachedFoodSuggestions;

  // Load food suggestions from JSON file
  static Future<List<FoodSuggestion>> loadFoodSuggestions() async {
    if (_cachedFoodSuggestions != null) {
      return _cachedFoodSuggestions!;
    }

    try {
      // Load JSON file from assets
      final String jsonString = await rootBundle.loadString(
        'assets/foods_data.json',
      );
      final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;

      // Convert JSON to FoodSuggestion objects
      _cachedFoodSuggestions = jsonList
          .map((json) => FoodSuggestion.fromJson(json as Map<String, dynamic>))
          .toList();

      return _cachedFoodSuggestions!;
    } catch (e) {
      debugPrint('Error loading food suggestions: $e');
      return [];
    }
  }

  // Get food suggestions (synchronous version - returns cached data)
  static List<FoodSuggestion> getFoodSuggestions() {
    if (_cachedFoodSuggestions != null) {
      return _cachedFoodSuggestions!;
    }
    // Return empty list if not loaded yet
    return [];
  }

  // Clear cache (useful for testing or reloading)
  static void clearCache() {
    _cachedFoodSuggestions = null;
  }

  // Get foods by type
  static List<FoodSuggestion> getFoodsByType(String type) {
    return getFoodSuggestions().where((food) => food.type == type).toList();
  }

  // Get foods by dosha rating
  static List<FoodSuggestion> getFoodsByDosha(
    String dosha, {
    int minRating = 4,
  }) {
    return getFoodSuggestions()
        .where(
          (food) =>
              food.doshaRatings[dosha] != null &&
              food.doshaRatings[dosha]! >= minRating,
        )
        .toList();
  }

  // Get foods to avoid for a dosha
  static List<FoodSuggestion> getFoodsToAvoid(
    String dosha, {
    int maxRating = 2,
  }) {
    return getFoodSuggestions()
        .where(
          (food) =>
              food.doshaRatings[dosha] != null &&
              food.doshaRatings[dosha]! <= maxRating,
        )
        .toList();
  }

  // Get food by name
  static FoodSuggestion? getFoodByName(String name) {
    try {
      return getFoodSuggestions().firstWhere(
        (food) => food.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }
}

// Legacy support - keep the old variable name for backward compatibility
// This will be deprecated in favor of using FoodSuggestionsLoader
@Deprecated('Use FoodSuggestionsLoader.loadFoodSuggestions() instead')
Future<List<FoodSuggestion>> get foodSuggestions async {
  return await FoodSuggestionsLoader.loadFoodSuggestions();
}
