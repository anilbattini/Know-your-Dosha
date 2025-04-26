class FoodSuggestion {
  final String name;
  final String type; // e.g., 'grain', 'fruit', 'oil', 'vegetable', 'spice', etc.
  final Map<String, int> doshaRatings; // e.g., {'vata': 5, 'pitta': 2, 'kapha': 1}
  final String? imageAsset;

  const FoodSuggestion({
    required this.name,
    required this.type,
    required this.doshaRatings,
    this.imageAsset,
  });
}

// Ratings: 5 = highly recommended, 1 = avoid
const List<FoodSuggestion> foodSuggestions = [
  // Grains
  FoodSuggestion(name: 'Oats', type: 'grain', doshaRatings: {'vata': 5, 'pitta': 4, 'kapha': 2}, imageAsset: 'assets/foods/oats.png'),
  FoodSuggestion(name: 'Basmati Rice', type: 'grain', doshaRatings: {'vata': 5, 'pitta': 5, 'kapha': 3}, imageAsset: 'assets/foods/basmati_rice.png'),
  FoodSuggestion(name: 'Quinoa', type: 'grain', doshaRatings: {'vata': 4, 'pitta': 5, 'kapha': 4}, imageAsset: 'assets/foods/quinoa.png'),
  FoodSuggestion(name: 'Wheat', type: 'grain', doshaRatings: {'vata': 4, 'pitta': 3, 'kapha': 2}, imageAsset: 'assets/foods/wheat.png'),
  FoodSuggestion(name: 'Barley', type: 'grain', doshaRatings: {'vata': 2, 'pitta': 4, 'kapha': 5}, imageAsset: 'assets/foods/barley.png'),
  FoodSuggestion(name: 'Millet', type: 'grain', doshaRatings: {'vata': 2, 'pitta': 3, 'kapha': 5}, imageAsset: 'assets/foods/millet.png'),
  FoodSuggestion(name: 'Brown Rice', type: 'grain', doshaRatings: {'vata': 1, 'pitta': 4, 'kapha': 3}, imageAsset: 'assets/foods/brown_rice.png'),
  FoodSuggestion(name: 'Corn', type: 'grain', doshaRatings: {'vata': 2, 'pitta': 2, 'kapha': 4}, imageAsset: 'assets/foods/corn.png'),
  FoodSuggestion(name: 'Rye', type: 'grain', doshaRatings: {'vata': 2, 'pitta': 3, 'kapha': 5}, imageAsset: 'assets/foods/rye.png'),
  FoodSuggestion(name: 'Rice Noodles', type: 'grain', doshaRatings: {'vata': 5, 'pitta': 4, 'kapha': 2}, imageAsset: 'assets/foods/rice_noodles.png'),

  // Fruits
  FoodSuggestion(name: 'Banana', type: 'fruit', doshaRatings: {'vata': 5, 'pitta': 4, 'kapha': 2}, imageAsset: 'assets/foods/banana.png'),
  FoodSuggestion(name: 'Mango', type: 'fruit', doshaRatings: {'vata': 5, 'pitta': 5, 'kapha': 3}, imageAsset: 'assets/foods/mango.png'),
  FoodSuggestion(name: 'Apple (baked)', type: 'fruit', doshaRatings: {'vata': 4, 'pitta': 4, 'kapha': 2}, imageAsset: 'assets/foods/apple.png'),
  FoodSuggestion(name: 'Grapes', type: 'fruit', doshaRatings: {'vata': 5, 'pitta': 5, 'kapha': 2}, imageAsset: 'assets/foods/grapes.png'),
  FoodSuggestion(name: 'Avocado', type: 'fruit', doshaRatings: {'vata': 5, 'pitta': 3, 'kapha': 1}, imageAsset: 'assets/foods/avocado.png'),
  FoodSuggestion(name: 'Coconut', type: 'fruit', doshaRatings: {'vata': 5, 'pitta': 5, 'kapha': 2}, imageAsset: 'assets/foods/coconut.png'),
  FoodSuggestion(name: 'Pomegranate', type: 'fruit', doshaRatings: {'vata': 3, 'pitta': 5, 'kapha': 4}, imageAsset: 'assets/foods/pomegranate.png'),
  FoodSuggestion(name: 'Pear (baked)', type: 'fruit', doshaRatings: {'vata': 4, 'pitta': 4, 'kapha': 2}, imageAsset: 'assets/foods/pear.png'),
  FoodSuggestion(name: 'Papaya', type: 'fruit', doshaRatings: {'vata': 5, 'pitta': 5, 'kapha': 3}, imageAsset: 'assets/foods/papaya.png'),
  FoodSuggestion(name: 'Melon', type: 'fruit', doshaRatings: {'vata': 3, 'pitta': 5, 'kapha': 4}, imageAsset: 'assets/foods/melon.png'),

  // Oils
  FoodSuggestion(name: 'Ghee', type: 'oil', doshaRatings: {'vata': 5, 'pitta': 5, 'kapha': 2}, imageAsset: 'assets/foods/ghee.png'),
  FoodSuggestion(name: 'Olive Oil', type: 'oil', doshaRatings: {'vata': 5, 'pitta': 4, 'kapha': 3}, imageAsset: 'assets/foods/olive_oil.png'),
  FoodSuggestion(name: 'Coconut Oil', type: 'oil', doshaRatings: {'vata': 5, 'pitta': 5, 'kapha': 2}, imageAsset: 'assets/foods/coconut_oil.png'),
  FoodSuggestion(name: 'Sesame Oil', type: 'oil', doshaRatings: {'vata': 5, 'pitta': 3, 'kapha': 2}, imageAsset: 'assets/foods/sesame_oil.png'),
  FoodSuggestion(name: 'Sunflower Oil', type: 'oil', doshaRatings: {'vata': 4, 'pitta': 5, 'kapha': 3}, imageAsset: 'assets/foods/sunflower_oil.png'),
  FoodSuggestion(name: 'Flaxseed Oil', type: 'oil', doshaRatings: {'vata': 4, 'pitta': 4, 'kapha': 2}, imageAsset: 'assets/foods/flaxseed_oil.png'),
  FoodSuggestion(name: 'Mustard Oil', type: 'oil', doshaRatings: {'vata': 2, 'pitta': 3, 'kapha': 5}, imageAsset: 'assets/foods/mustard_oil.png'),
  FoodSuggestion(name: 'Almond Oil', type: 'oil', doshaRatings: {'vata': 5, 'pitta': 4, 'kapha': 2}, imageAsset: 'assets/foods/almond_oil.png'),
  FoodSuggestion(name: 'Avocado Oil', type: 'oil', doshaRatings: {'vata': 5, 'pitta': 3, 'kapha': 1}, imageAsset: 'assets/foods/avocado_oil.png'),
  FoodSuggestion(name: 'Canola Oil', type: 'oil', doshaRatings: {'vata': 3, 'pitta': 4, 'kapha': 2}, imageAsset: 'assets/foods/canola_oil.png'),

  // Vegetables
  FoodSuggestion(name: 'Sweet Potato', type: 'vegetable', doshaRatings: {'vata': 5, 'pitta': 4, 'kapha': 2}, imageAsset: 'assets/foods/sweet_potato.png'),
  FoodSuggestion(name: 'Carrot', type: 'vegetable', doshaRatings: {'vata': 5, 'pitta': 4, 'kapha': 2}, imageAsset: 'assets/foods/carrot.png'),
  FoodSuggestion(name: 'Beetroot', type: 'vegetable', doshaRatings: {'vata': 5, 'pitta': 4, 'kapha': 2}, imageAsset: 'assets/foods/beetroot.png'),
  FoodSuggestion(name: 'Zucchini', type: 'vegetable', doshaRatings: {'vata': 4, 'pitta': 4, 'kapha': 3}, imageAsset: 'assets/foods/zucchini.png'),
  FoodSuggestion(name: 'Spinach (cooked)', type: 'vegetable', doshaRatings: {'vata': 3, 'pitta': 5, 'kapha': 4}, imageAsset: 'assets/foods/spinach.png'),
  FoodSuggestion(name: 'Broccoli (cooked)', type: 'vegetable', doshaRatings: {'vata': 2, 'pitta': 4, 'kapha': 5}, imageAsset: 'assets/foods/broccoli.png'),
  FoodSuggestion(name: 'Pumpkin', type: 'vegetable', doshaRatings: {'vata': 5, 'pitta': 4, 'kapha': 2}, imageAsset: 'assets/foods/pumpkin.png'),
  FoodSuggestion(name: 'Green Beans', type: 'vegetable', doshaRatings: {'vata': 4, 'pitta': 4, 'kapha': 3}, imageAsset: 'assets/foods/green_beans.png'),
  FoodSuggestion(name: 'Cabbage (cooked)', type: 'vegetable', doshaRatings: {'vata': 2, 'pitta': 4, 'kapha': 5}, imageAsset: 'assets/foods/cabbage.png'),
  FoodSuggestion(name: 'Asparagus', type: 'vegetable', doshaRatings: {'vata': 4, 'pitta': 5, 'kapha': 3}, imageAsset: 'assets/foods/asparagus.png'),

  // Spices
  FoodSuggestion(name: 'Cinnamon', type: 'spice', doshaRatings: {'vata': 5, 'pitta': 3, 'kapha': 5}, imageAsset: 'assets/foods/cinnamon.png'),
  FoodSuggestion(name: 'Cardamom', type: 'spice', doshaRatings: {'vata': 5, 'pitta': 4, 'kapha': 4}, imageAsset: 'assets/foods/cardamom.png'),
  FoodSuggestion(name: 'Ginger', type: 'spice', doshaRatings: {'vata': 5, 'pitta': 3, 'kapha': 5}, imageAsset: 'assets/foods/ginger.png'),
  FoodSuggestion(name: 'Cumin', type: 'spice', doshaRatings: {'vata': 5, 'pitta': 5, 'kapha': 4}, imageAsset: 'assets/foods/cumin.png'),
  FoodSuggestion(name: 'Turmeric', type: 'spice', doshaRatings: {'vata': 4, 'pitta': 5, 'kapha': 5}, imageAsset: 'assets/foods/turmeric.png'),
  FoodSuggestion(name: 'Black Pepper', type: 'spice', doshaRatings: {'vata': 3, 'pitta': 2, 'kapha': 5}, imageAsset: 'assets/foods/black_pepper.png'),
  FoodSuggestion(name: 'Fennel', type: 'spice', doshaRatings: {'vata': 4, 'pitta': 5, 'kapha': 3}, imageAsset: 'assets/foods/fennel.png'),
  FoodSuggestion(name: 'Clove', type: 'spice', doshaRatings: {'vata': 4, 'pitta': 3, 'kapha': 5}, imageAsset: 'assets/foods/clove.png'),
  FoodSuggestion(name: 'Mustard Seed', type: 'spice', doshaRatings: {'vata': 2, 'pitta': 2, 'kapha': 5}, imageAsset: 'assets/foods/mustard_seed.png'),
  FoodSuggestion(name: 'Hing (Asafoetida)', type: 'spice', doshaRatings: {'vata': 5, 'pitta': 4, 'kapha': 4}, imageAsset: 'assets/foods/hing.png'),

  // Legumes & Beans
  FoodSuggestion(name: 'Moong Dal', type: 'legume', doshaRatings: {'vata': 5, 'pitta': 5, 'kapha': 4}, imageAsset: 'assets/foods/moong_dal.png'),
  FoodSuggestion(name: 'Toor Dal', type: 'legume', doshaRatings: {'vata': 3, 'pitta': 4, 'kapha': 4}, imageAsset: 'assets/foods/toor_dal.png'),
  FoodSuggestion(name: 'Masoor Dal', type: 'legume', doshaRatings: {'vata': 3, 'pitta': 3, 'kapha': 4}, imageAsset: 'assets/foods/masoor_dal.png'),
  FoodSuggestion(name: 'Chickpeas', type: 'legume', doshaRatings: {'vata': 2, 'pitta': 4, 'kapha': 5}, imageAsset: 'assets/foods/chickpeas.png'),
  FoodSuggestion(name: 'Kidney Beans', type: 'legume', doshaRatings: {'vata': 1, 'pitta': 3, 'kapha': 4}, imageAsset: 'assets/foods/kidney_beans.png'),

  // Dairy & Alternatives
  FoodSuggestion(name: 'Yogurt (fresh)', type: 'dairy', doshaRatings: {'vata': 3, 'pitta': 3, 'kapha': 2}, imageAsset: 'assets/foods/yogurt.png'),
  FoodSuggestion(name: 'Paneer', type: 'dairy', doshaRatings: {'vata': 4, 'pitta': 3, 'kapha': 1}, imageAsset: 'assets/foods/paneer.png'),
  FoodSuggestion(name: 'Buttermilk', type: 'dairy', doshaRatings: {'vata': 5, 'pitta': 5, 'kapha': 4}, imageAsset: 'assets/foods/buttermilk.png'),
  FoodSuggestion(name: 'Almond Milk', type: 'dairy', doshaRatings: {'vata': 5, 'pitta': 4, 'kapha': 2}, imageAsset: 'assets/foods/almond_milk.png'),

  // Nuts & Seeds
  FoodSuggestion(name: 'Almonds (soaked)', type: 'nut', doshaRatings: {'vata': 5, 'pitta': 4, 'kapha': 2}, imageAsset: 'assets/foods/almonds.png'),
  FoodSuggestion(name: 'Walnuts', type: 'nut', doshaRatings: {'vata': 5, 'pitta': 3, 'kapha': 2}, imageAsset: 'assets/foods/walnuts.png'),
  FoodSuggestion(name: 'Pumpkin Seeds', type: 'seed', doshaRatings: {'vata': 4, 'pitta': 4, 'kapha': 4}, imageAsset: 'assets/foods/pumpkin_seeds.png'),
  FoodSuggestion(name: 'Sunflower Seeds', type: 'seed', doshaRatings: {'vata': 4, 'pitta': 5, 'kapha': 3}, imageAsset: 'assets/foods/sunflower_seeds.png'),
  FoodSuggestion(name: 'Chia Seeds', type: 'seed', doshaRatings: {'vata': 3, 'pitta': 4, 'kapha': 4}, imageAsset: 'assets/foods/chia_seeds.png'),

  // Sweeteners
  FoodSuggestion(name: 'Jaggery', type: 'sweetener', doshaRatings: {'vata': 5, 'pitta': 3, 'kapha': 2}, imageAsset: 'assets/foods/jaggery.png'),
  FoodSuggestion(name: 'Honey (raw)', type: 'sweetener', doshaRatings: {'vata': 3, 'pitta': 2, 'kapha': 5}, imageAsset: 'assets/foods/honey.png'),
  FoodSuggestion(name: 'Maple Syrup', type: 'sweetener', doshaRatings: {'vata': 4, 'pitta': 4, 'kapha': 2}, imageAsset: 'assets/foods/maple_syrup.png'),

  // Indian Dishes
  FoodSuggestion(name: 'Kitchari', type: 'dish', doshaRatings: {'vata': 5, 'pitta': 5, 'kapha': 4}, imageAsset: 'assets/foods/kitchari.png'),
  FoodSuggestion(name: 'Roti/Chapathi', type: 'dish', doshaRatings: {'vata': 4, 'pitta': 4, 'kapha': 2}, imageAsset: 'assets/foods/roti.png'),
  FoodSuggestion(name: 'Dosa', type: 'dish', doshaRatings: {'vata': 3, 'pitta': 3, 'kapha': 3}, imageAsset: 'assets/foods/dosa.png'),
  FoodSuggestion(name: 'Idli', type: 'dish', doshaRatings: {'vata': 4, 'pitta': 4, 'kapha': 3}, imageAsset: 'assets/foods/idli.png'),
]; 