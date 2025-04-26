# Dosha Quiz App

A comprehensive Flutter application that helps users discover their dominant Ayurvedic dosha (Vata, Pitta, or Kapha) through an interactive quiz and provides personalized food and lifestyle recommendations.

## Features

### 🧘‍♀️ Interactive Dosha Quiz
- **Dynamic Question System**: Starts with 10 questions and adaptively asks more (up to 30) if results are ambiguous
- **Follow-up Questions**: Intelligent follow-up questions based on user responses for more accurate results
- **Progress Tracking**: Visual progress indicator showing quiz completion
- **Real-time Scoring**: Calculates dosha scores as users answer questions

### 🍎 Personalized Food Recommendations
- **Comprehensive Food Database**: 60+ foods with dosha-specific ratings (1-5 scale)
- **Visual Food Display**: Food images with clear recommendations
- **Dosha-Specific Suggestions**: 
  - Foods to favor (rating ≥ 4)
  - Foods to reduce (rating ≤ 2)
- **Food Categories**: Grains, fruits, vegetables, oils, spices, dairy, and more

### 🌿 Lifestyle Guidance
- **Dosha-Specific Tips**: Personalized lifestyle recommendations for each dosha
- **Visual Lifestyle Cards**: Beautiful lifestyle images with actionable tips
- **Comprehensive Advice**: Exercise, diet, daily routine, and wellness practices

### 🎨 Beautiful User Interface
- **Modern Design**: Clean, intuitive interface with dosha-specific color themes
- **Responsive Layout**: Works seamlessly across different screen sizes
- **Visual Feedback**: Progress bars, dosha score visualization, and interactive elements

### 🔧 Advanced Features
- **Admin Mode**: Tap the title 5 times to enable admin mode with dosha indicators
- **Adaptive Quiz Logic**: Smart question selection and result calculation
- **Cached Data**: Efficient food data loading and caching
- **Error Handling**: Graceful fallbacks for missing images and data

## Dosha Types

### Vata (Air & Space)
- **Characteristics**: Energetic, creative, lively
- **Challenges**: Anxiety, dryness, irregular patterns
- **Color Theme**: Blue/Purple

### Pitta (Fire & Water)
- **Characteristics**: Passionate, intelligent, driven
- **Challenges**: Irritability, overheating, inflammation
- **Color Theme**: Orange/Red

### Kapha (Earth & Water)
- **Characteristics**: Calm, steady, nurturing
- **Challenges**: Sluggishness, weight gain, attachment
- **Color Theme**: Green/Brown

## Technical Details

### Architecture
- **Flutter Framework**: Cross-platform mobile development
- **Modular Design**: Separated core logic, UI components, and data
- **State Management**: Efficient state handling with StatefulWidget

### Data Management
- **JSON-based Food Database**: 60+ foods with dosha ratings
- **Asset Management**: Comprehensive image assets for foods and lifestyle
- **Caching System**: Efficient data loading and memory management

### Testing
- **Unit Tests**: Core logic and food suggestions testing
- **Widget Tests**: UI component and quiz flow testing
- **Comprehensive Coverage**: Tests for all major functionality

## Getting Started

### Prerequisites
- Flutter SDK (^3.8.1)
- Dart SDK
- Android Studio / VS Code

### Installation
1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Ensure all assets are properly included in `pubspec.yaml`
4. Run `flutter run` to start the application

### Project Structure
```
lib/
├── core/                    # Core logic and data
│   ├── app_style.dart      # UI styling and themes
│   ├── color_palette.dart  # Color definitions
│   ├── food_suggestions.dart # Food data management
│   ├── questions.dart       # Quiz questions
│   └── quiz_logic.dart     # Quiz scoring and logic
├── screens/                 # UI screens
│   ├── welcome_screen.dart # Welcome/landing screen
│   ├── quiz_screen.dart    # Main quiz interface
│   └── result_screen.dart  # Results and recommendations
└── main.dart               # App entry point
```

## Assets

### Food Images
- 60+ high-quality food images
- Organized in `assets/foods/` directory
- Fallback images for missing assets

### Lifestyle Images
- Dosha-specific lifestyle guidance images
- Visual representation of wellness practices

### Data Files
- `foods_data.json`: Comprehensive food database with dosha ratings
- Structured for easy maintenance and updates

## Development

### Adding New Foods
1. Add food image to `assets/foods/`
2. Update `assets/foods_data.json` with food details and dosha ratings
3. Ensure proper dosha ratings (1-5 scale)

### Customizing Questions
- Modify `lib/core/questions.dart` to add or modify quiz questions
- Follow-up questions can be added for more detailed assessment

### Styling Updates
- Update `lib/core/app_style.dart` for theme changes
- Modify `lib/core/color_palette.dart` for color scheme updates

## Testing

Run the test suite:
```bash
flutter test
```

Individual test files:
- `test/food_suggestions_test.dart`: Food data and recommendations
- `test/quiz_logic_test.dart`: Quiz scoring and logic
- `test/widget_quiz_flow_test.dart`: UI flow testing
- `test/widget_test.dart`: Basic widget testing

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Ayurvedic principles and dosha classifications
- Food recommendations based on traditional Ayurvedic wisdom
- Flutter community for excellent documentation and tools
