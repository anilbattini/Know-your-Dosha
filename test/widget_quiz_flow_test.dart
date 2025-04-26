import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:dosha_quiz_app/main.dart';

void main() {
  testWidgets('Quiz flow: start, answer, see result', (WidgetTester tester) async {
    await tester.pumpWidget(const DoshaQuizApp());

    // Welcome screen
    expect(find.text('Discover Your Dominant Dosha'), findsOneWidget);
    expect(find.text('Start Quiz'), findsOneWidget);
    await tester.tap(find.text('Start Quiz'));
    await tester.pumpAndSettle();

    // Answer 10 questions (always pick first option)
    for (int i = 0; i < 10; i++) {
      expect(find.textContaining('Question'), findsOneWidget);
      final option = find.byType(ElevatedButton).first;
      await tester.tap(option);
      await tester.pumpAndSettle();
    }

    // Result screen
    expect(find.text('Your Dominant Dosha'), findsOneWidget);
    expect(find.text('Retake Quiz'), findsOneWidget);
  });
} 