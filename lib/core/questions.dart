import 'dart:math';
// Know Your Dosha questions and options
class DoshaQuestion {
  final String question;
  final List<DoshaOption> options;
  final String? followUpKey; // key to trigger follow-up
  final List<DoshaQuestion>? followUps;

  DoshaQuestion({
    required this.question,
    required this.options,
    this.followUpKey,
    this.followUps,
  });

  List<DoshaOption> getShuffledOptions([Random? random]) {
    final opts = List<DoshaOption>.from(options);
    opts.shuffle(random);
    return opts;
  }
}

class DoshaOption {
  final String text;
  final String dosha; // 'vata', 'pitta', 'kapha'
  final String? followUpKey; // key to trigger follow-up

  DoshaOption({required this.text, required this.dosha, this.followUpKey});
}

final List<DoshaQuestion> doshaQuestions = [
  DoshaQuestion(
    question: 'What best describes your body frame?',
    options: [
      DoshaOption(text: 'Thin, lanky, and tall', dosha: 'vata', followUpKey: 'body_frame'),
      DoshaOption(text: 'Medium, athletic build', dosha: 'pitta', followUpKey: 'body_frame'),
      DoshaOption(text: 'Large, broad, and sturdy', dosha: 'kapha', followUpKey: 'body_frame'),
    ],
    followUpKey: 'body_frame',
    followUps: [
      DoshaQuestion(
        question: 'Do you find it easy or hard to gain weight?',
        options: [
          DoshaOption(text: 'Very hard', dosha: 'vata'),
          DoshaOption(text: 'Moderate', dosha: 'pitta'),
          DoshaOption(text: 'Very easy', dosha: 'kapha'),
        ],
      ),
    ],
  ),
  DoshaQuestion(
    question: 'How is your skin texture?',
    options: [
      DoshaOption(text: 'Dry, rough, or thin', dosha: 'vata', followUpKey: 'skin'),
      DoshaOption(text: 'Warm, oily, or prone to rashes', dosha: 'pitta', followUpKey: 'skin'),
      DoshaOption(text: 'Smooth, moist, or thick', dosha: 'kapha', followUpKey: 'skin'),
    ],
    followUpKey: 'skin',
    followUps: [
      DoshaQuestion(
        question: 'Do you get rashes or acne easily?',
        options: [
          DoshaOption(text: 'Yes, often', dosha: 'pitta'),
          DoshaOption(text: 'Rarely', dosha: 'kapha'),
          DoshaOption(text: 'No, but skin is dry', dosha: 'vata'),
        ],
      ),
    ],
  ),
  DoshaQuestion(
    question: 'How is your appetite?',
    options: [
      DoshaOption(text: 'Irregular, sometimes forget to eat', dosha: 'vata', followUpKey: 'appetite'),
      DoshaOption(text: 'Strong, get irritable if miss a meal', dosha: 'pitta', followUpKey: 'appetite'),
      DoshaOption(text: 'Steady, can skip meals easily', dosha: 'kapha', followUpKey: 'appetite'),
    ],
    followUpKey: 'appetite',
    followUps: [
      DoshaQuestion(
        question: 'Do you feel weak or angry if you miss a meal?',
        options: [
          DoshaOption(text: 'Angry', dosha: 'pitta'),
          DoshaOption(text: 'Weak', dosha: 'vata'),
          DoshaOption(text: 'No effect', dosha: 'kapha'),
        ],
      ),
    ],
  ),
  DoshaQuestion(
    question: 'How do you react to stress?',
    options: [
      DoshaOption(text: 'Anxious, worried, restless', dosha: 'vata', followUpKey: 'stress'),
      DoshaOption(text: 'Irritable, angry, impatient', dosha: 'pitta', followUpKey: 'stress'),
      DoshaOption(text: 'Withdrawn, lethargic, depressed', dosha: 'kapha', followUpKey: 'stress'),
    ],
    followUpKey: 'stress',
    followUps: [
      DoshaQuestion(
        question: 'Do you tend to overthink or get headaches under stress?',
        options: [
          DoshaOption(text: 'Overthink', dosha: 'vata'),
          DoshaOption(text: 'Headaches', dosha: 'pitta'),
          DoshaOption(text: 'Sleep more', dosha: 'kapha'),
        ],
      ),
    ],
  ),
  DoshaQuestion(
    question: 'How is your sleep?',
    options: [
      DoshaOption(text: 'Light, interrupted, trouble falling asleep', dosha: 'vata', followUpKey: 'sleep'),
      DoshaOption(text: 'Moderate, can wake up easily', dosha: 'pitta', followUpKey: 'sleep'),
      DoshaOption(text: 'Deep, heavy, hard to wake up', dosha: 'kapha', followUpKey: 'sleep'),
    ],
    followUpKey: 'sleep',
    followUps: [
      DoshaQuestion(
        question: 'Do you dream a lot or wake up tired?',
        options: [
          DoshaOption(text: 'Dream a lot', dosha: 'vata'),
          DoshaOption(text: 'Wake up tired', dosha: 'kapha'),
          DoshaOption(text: 'Wake up alert', dosha: 'pitta'),
        ],
      ),
    ],
  ),
  DoshaQuestion(
    question: 'How is your memory?',
    options: [
      DoshaOption(text: 'Quick to learn, quick to forget', dosha: 'vata'),
      DoshaOption(text: 'Sharp, good recall', dosha: 'pitta'),
      DoshaOption(text: 'Slow to learn, slow to forget', dosha: 'kapha'),
    ],
  ),
  DoshaQuestion(
    question: 'How is your energy level?',
    options: [
      DoshaOption(text: 'Variable, comes in bursts', dosha: 'vata'),
      DoshaOption(text: 'Consistent, high energy', dosha: 'pitta'),
      DoshaOption(text: 'Steady, but slow', dosha: 'kapha'),
    ],
  ),
  DoshaQuestion(
    question: 'How is your hair?',
    options: [
      DoshaOption(text: 'Dry, frizzy, thin', dosha: 'vata'),
      DoshaOption(text: 'Fine, straight, early graying', dosha: 'pitta'),
      DoshaOption(text: 'Thick, wavy, oily', dosha: 'kapha'),
    ],
  ),
  DoshaQuestion(
    question: 'How is your body temperature?',
    options: [
      DoshaOption(text: 'Often cold, hands and feet cold', dosha: 'vata'),
      DoshaOption(text: 'Warm, dislike heat', dosha: 'pitta'),
      DoshaOption(text: 'Cool, but tolerate cold well', dosha: 'kapha'),
    ],
  ),
  DoshaQuestion(
    question: 'How is your digestion?',
    options: [
      DoshaOption(text: 'Irregular, gas or bloating', dosha: 'vata'),
      DoshaOption(text: 'Strong, can eat anything', dosha: 'pitta'),
      DoshaOption(text: 'Slow, heavy after meals', dosha: 'kapha'),
    ],
  ),
  // 20 more questions for a total of 30+
  DoshaQuestion(
    question: 'How do you handle cold weather?',
    options: [
      DoshaOption(text: 'Dislike, get cold easily', dosha: 'vata'),
      DoshaOption(text: 'Tolerate, but prefer cool', dosha: 'pitta'),
      DoshaOption(text: 'Like, feel comfortable', dosha: 'kapha'),
    ],
  ),
  DoshaQuestion(
    question: 'How do you handle hot weather?',
    options: [
      DoshaOption(text: 'Like, feel comfortable', dosha: 'vata'),
      DoshaOption(text: 'Dislike, get overheated', dosha: 'pitta'),
      DoshaOption(text: 'Tolerate, but prefer warmth', dosha: 'kapha'),
    ],
  ),
  DoshaQuestion(
    question: 'How is your walking style?',
    options: [
      DoshaOption(text: 'Quick, light', dosha: 'vata'),
      DoshaOption(text: 'Purposeful, determined', dosha: 'pitta'),
      DoshaOption(text: 'Slow, steady', dosha: 'kapha'),
    ],
  ),
  DoshaQuestion(
    question: 'How is your speech?',
    options: [
      DoshaOption(text: 'Fast, talkative', dosha: 'vata'),
      DoshaOption(text: 'Sharp, precise', dosha: 'pitta'),
      DoshaOption(text: 'Slow, calm', dosha: 'kapha'),
    ],
  ),
  DoshaQuestion(
    question: 'How is your perspiration?',
    options: [
      DoshaOption(text: 'Minimal', dosha: 'vata'),
      DoshaOption(text: 'Profuse, strong odor', dosha: 'pitta'),
      DoshaOption(text: 'Moderate, little odor', dosha: 'kapha'),
    ],
  ),
  DoshaQuestion(
    question: 'How is your emotional response?',
    options: [
      DoshaOption(text: 'Fearful, anxious', dosha: 'vata'),
      DoshaOption(text: 'Angry, frustrated', dosha: 'pitta'),
      DoshaOption(text: 'Calm, content', dosha: 'kapha'),
    ],
  ),
  DoshaQuestion(
    question: 'How is your endurance?',
    options: [
      DoshaOption(text: 'Low, tire easily', dosha: 'vata'),
      DoshaOption(text: 'Moderate, good stamina', dosha: 'pitta'),
      DoshaOption(text: 'High, can sustain long activity', dosha: 'kapha'),
    ],
  ),
  DoshaQuestion(
    question: 'How is your financial management?',
    options: [
      DoshaOption(text: 'Spend impulsively', dosha: 'vata'),
      DoshaOption(text: 'Spend on quality, calculated', dosha: 'pitta'),
      DoshaOption(text: 'Save, cautious', dosha: 'kapha'),
    ],
  ),
  DoshaQuestion(
    question: 'How is your response to change?',
    options: [
      DoshaOption(text: 'Adapt quickly', dosha: 'vata'),
      DoshaOption(text: 'Resist, prefer control', dosha: 'pitta'),
      DoshaOption(text: 'Slow to adapt', dosha: 'kapha'),
    ],
  ),
  DoshaQuestion(
    question: 'How is your social behavior?',
    options: [
      DoshaOption(text: 'Outgoing, meet new people', dosha: 'vata'),
      DoshaOption(text: 'Selective, few close friends', dosha: 'pitta'),
      DoshaOption(text: 'Loyal, long-term friends', dosha: 'kapha'),
    ],
  ),
  DoshaQuestion(
    question: 'How is your reaction to fasting?',
    options: [
      DoshaOption(text: 'Feel weak, anxious', dosha: 'vata'),
      DoshaOption(text: 'Irritable, angry', dosha: 'pitta'),
      DoshaOption(text: 'Can manage easily', dosha: 'kapha'),
    ],
  ),
  DoshaQuestion(
    question: 'How is your pulse?',
    options: [
      DoshaOption(text: 'Fast, irregular', dosha: 'vata'),
      DoshaOption(text: 'Strong, bounding', dosha: 'pitta'),
      DoshaOption(text: 'Slow, steady', dosha: 'kapha'),
    ],
  ),
  DoshaQuestion(
    question: 'How is your body weight?',
    options: [
      DoshaOption(text: 'Low, hard to gain', dosha: 'vata'),
      DoshaOption(text: 'Moderate, can gain/lose', dosha: 'pitta'),
      DoshaOption(text: 'Gain easily, hard to lose', dosha: 'kapha'),
    ],
  ),
  DoshaQuestion(
    question: 'How is your bowel movement?',
    options: [
      DoshaOption(text: 'Dry, hard, irregular', dosha: 'vata'),
      DoshaOption(text: 'Loose, frequent', dosha: 'pitta'),
      DoshaOption(text: 'Slow, heavy', dosha: 'kapha'),
    ],
  ),
  DoshaQuestion(
    question: 'How is your sexual drive?',
    options: [
      DoshaOption(text: 'Variable, low', dosha: 'vata'),
      DoshaOption(text: 'Strong, passionate', dosha: 'pitta'),
      DoshaOption(text: 'Steady, moderate', dosha: 'kapha'),
    ],
  ),
  DoshaQuestion(
    question: 'How is your decision making?',
    options: [
      DoshaOption(text: 'Indecisive, change mind', dosha: 'vata'),
      DoshaOption(text: 'Quick, confident', dosha: 'pitta'),
      DoshaOption(text: 'Slow, deliberate', dosha: 'kapha'),
    ],
  ),
  DoshaQuestion(
    question: 'How is your sense of humor?',
    options: [
      DoshaOption(text: 'Witty, quick', dosha: 'vata'),
      DoshaOption(text: 'Sarcastic, sharp', dosha: 'pitta'),
      DoshaOption(text: 'Warm, gentle', dosha: 'kapha'),
    ],
  ),
  DoshaQuestion(
    question: 'How is your handwriting?',
    options: [
      DoshaOption(text: 'Irregular, variable', dosha: 'vata'),
      DoshaOption(text: 'Neat, precise', dosha: 'pitta'),
      DoshaOption(text: 'Large, rounded', dosha: 'kapha'),
    ],
  ),
  DoshaQuestion(
    question: 'How is your voice?',
    options: [
      DoshaOption(text: 'High-pitched, variable', dosha: 'vata'),
      DoshaOption(text: 'Sharp, commanding', dosha: 'pitta'),
      DoshaOption(text: 'Deep, steady', dosha: 'kapha'),
    ],
  ),
  DoshaQuestion(
    question: 'How is your reaction to travel?',
    options: [
      DoshaOption(text: 'Love, get excited', dosha: 'vata'),
      DoshaOption(text: 'Like, but plan ahead', dosha: 'pitta'),
      DoshaOption(text: 'Prefer routine, dislike change', dosha: 'kapha'),
    ],
  ),
  DoshaQuestion(
    question: 'How is your reaction to criticism?',
    options: [
      DoshaOption(text: 'Take it personally, anxious', dosha: 'vata'),
      DoshaOption(text: 'Defensive, angry', dosha: 'pitta'),
      DoshaOption(text: 'Accept, reflect', dosha: 'kapha'),
    ],
  ),
  DoshaQuestion(
    question: 'How is your reaction to deadlines?',
    options: [
      DoshaOption(text: 'Stressed, anxious', dosha: 'vata'),
      DoshaOption(text: 'Motivated, focused', dosha: 'pitta'),
      DoshaOption(text: 'Calm, take time', dosha: 'kapha'),
    ],
  ),
  DoshaQuestion(
    question: 'How is your reaction to conflict?',
    options: [
      DoshaOption(text: 'Avoid, withdraw', dosha: 'vata'),
      DoshaOption(text: 'Confront, resolve', dosha: 'pitta'),
      DoshaOption(text: 'Pacify, mediate', dosha: 'kapha'),
    ],
  ),
]; 