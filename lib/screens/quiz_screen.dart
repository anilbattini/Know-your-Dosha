import 'package:flutter/material.dart';
import '../core/questions.dart';
import '../core/quiz_logic.dart';
import '../core/color_palette.dart';
import 'result_screen.dart';
import 'dart:math';
import '../core/app_style.dart';

class QuizScreen extends StatefulWidget {
  final bool adminMode;
  const QuizScreen({super.key, this.adminMode = false});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestion = 0;
  final List<String> _selectedDoshas = [];
  int _questionsToAsk = DoshaQuizLogic.initialQuestions;
  late List<DoshaQuestion> _questions;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _questions = DoshaQuizLogic.getQuestions(_questionsToAsk);
  }

  void _onOptionSelected(DoshaOption option) {
    setState(() {
      _selectedDoshas.add(option.dosha);
      // Handle follow-up
      if (option.followUpKey != null) {
        final followUps = _questions[_currentQuestion].followUps;
        DoshaQuestion? followUp;
        if (followUps != null && followUps.isNotEmpty) {
          followUp = followUps.firstWhere(
            (q) => q.followUpKey == option.followUpKey,
            orElse: () => followUps.first,
          );
        }
        if (followUp != null) {
          _questions.insert(_currentQuestion + 1, followUp);
        }
      }
      _currentQuestion++;
      if (_currentQuestion >= _questionsToAsk) {
        final result = DoshaQuizLogic.calculateResult(
          _selectedDoshas,
          questionsAsked: _questionsToAsk,
        );
        if (result.isAmbiguous &&
            _questionsToAsk < DoshaQuizLogic.totalQuestions) {
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
                        style: AppStyle.subtitle,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _questions[_currentQuestion].question,
                        style: AppStyle.title,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      ..._questions[_currentQuestion]
                          .getShuffledOptions(_random)
                          .map(
                            (option) => Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: ElevatedButton(
                                style: AppStyle.elevatedButton.copyWith(
                                  backgroundColor: WidgetStateProperty.all(
                                    AppColors.card,
                                  ),
                                  foregroundColor: WidgetStateProperty.all(
                                    AppColors.textPrimary,
                                  ),
                                  minimumSize: WidgetStateProperty.all(
                                    const Size.fromHeight(48),
                                  ),
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                onPressed: () => _onOptionSelected(option),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(option.text, style: AppStyle.body),
                                    if (widget.adminMode)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 12.0,
                                        ),
                                        child: Text(
                                          option.dosha
                                              .substring(0, 1)
                                              .toUpperCase(),
                                          style: AppStyle.subtitle.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
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
