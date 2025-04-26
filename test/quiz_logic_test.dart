import 'package:flutter_test/flutter_test.dart';
import 'package:dosha_quiz_app/core/quiz_logic.dart';

void main() {
  group('DoshaQuizLogic', () {
    test('Detects clear dominant dosha', () {
      // 7 vata, 2 pitta, 1 kapha (difference >= 2)
      final answers = [
        'vata', 'vata', 'vata', 'vata', 'vata', 'vata', 'vata',
        'pitta', 'pitta', 'kapha',
      ];
      final result = DoshaQuizLogic.calculateResult(answers, questionsAsked: 10);
      expect(result.dominantDosha, 'vata');
      expect(result.isAmbiguous, false);
    });

    test('Detects ambiguous result and asks for more questions', () {
      // 4 vata, 3 pitta, 3 kapha (difference < 2)
      final answers = [
        'vata', 'vata', 'vata', 'vata',
        'pitta', 'pitta', 'pitta',
        'kapha', 'kapha', 'kapha',
      ];
      final result = DoshaQuizLogic.calculateResult(answers, questionsAsked: 10);
      expect(result.dominantDosha, null);
      expect(result.isAmbiguous, true);
    });

    test('Returns result at max questions even if ambiguous', () {
      // 10 vata, 10 pitta, 10 kapha (all equal)
      final answers = List<String>.filled(10, 'vata') +
          List<String>.filled(10, 'pitta') +
          List<String>.filled(10, 'kapha');
      final result = DoshaQuizLogic.calculateResult(answers, questionsAsked: 30);
      expect(result.dominantDosha, isNotNull);
      expect(result.isAmbiguous, false);
    });
  });
} 