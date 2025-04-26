import 'questions.dart';

class QuizResult {
  final String? dominantDosha;
  final bool isAmbiguous;
  final Map<String, int> doshaScores;

  QuizResult({this.dominantDosha, required this.isAmbiguous, required this.doshaScores});
}

class DoshaQuizLogic {
  static const int initialQuestions = 10;
  static const int totalQuestions = 30;
  static const int minDifference = 2; // Minimum difference to be clear

  // Returns the next set of questions to ask
  static List<DoshaQuestion> getQuestions(int count) {
    return doshaQuestions.take(count).toList();
  }

  // Scores answers and returns result
  static QuizResult calculateResult(List<String> selectedDoshas, {int questionsAsked = initialQuestions}) {
    final scores = {'vata': 0, 'pitta': 0, 'kapha': 0};
    for (final dosha in selectedDoshas) {
      if (scores.containsKey(dosha)) scores[dosha] = scores[dosha]! + 1;
    }
    // Find max
    final sorted = scores.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    final top = sorted[0];
    final second = sorted[1];
    // If top is clearly ahead, return
    if (top.value - second.value >= minDifference || questionsAsked == totalQuestions) {
      return QuizResult(dominantDosha: top.key, isAmbiguous: false, doshaScores: scores);
    } else {
      return QuizResult(dominantDosha: null, isAmbiguous: true, doshaScores: scores);
    }
  }
} 