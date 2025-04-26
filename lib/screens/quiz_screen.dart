import 'package:flutter/material.dart';
import '../core/questions.dart';
import '../core/quiz_logic.dart';
import '../core/color_palette.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestion = 0;
  final List<String> _selectedDoshas = [];
  int _questionsToAsk = DoshaQuizLogic.initialQuestions;
  late List<DoshaQuestion> _questions;

  @override
  void initState() {
    super.initState();
    _questions = DoshaQuizLogic.getQuestions(_questionsToAsk);
  }

  void _onOptionSelected(String dosha) {
    setState(() {
      _selectedDoshas.add(dosha);
      _currentQuestion++;
      if (_currentQuestion >= _questionsToAsk) {
        final result = DoshaQuizLogic.calculateResult(_selectedDoshas, questionsAsked: _questionsToAsk);
        if (result.isAmbiguous && _questionsToAsk < DoshaQuizLogic.totalQuestions) {
          // Ask more questions
          _questionsToAsk += 5;
          if (_questionsToAsk > DoshaQuizLogic.totalQuestions) {
            _questionsToAsk = DoshaQuizLogic.totalQuestions;
          }
          _questions = DoshaQuizLogic.getQuestions(_questionsToAsk);
        } else {
          // Show result
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(result: result),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LinearProgressIndicator(
                value: (_currentQuestion + 1) / _questionsToAsk,
                color: AppColors.progress,
                backgroundColor: AppColors.card,
                minHeight: 8,
              ),
              const SizedBox(height: 32),
              if (_currentQuestion < _questionsToAsk)
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Question ${_currentQuestion + 1} of $_questionsToAsk',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _questions[_currentQuestion].question,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      ..._questions[_currentQuestion].options.map((option) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.card,
                            foregroundColor: AppColors.textPrimary,
                            minimumSize: const Size.fromHeight(48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () => _onOptionSelected(option.dosha),
                          child: Text(
                            option.text,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
} 