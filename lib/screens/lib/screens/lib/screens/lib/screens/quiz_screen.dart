import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestion = 0;
  int _score = 0;
  int? _selectedOption;
  bool _isAnswered = false;
  bool _isFinished = false;

  // Sample questions
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What is Flutter?',
      'options': [
        'A programming language',
        'A UI toolkit by Google',
        'An operating system',
        'A database',
      ],
      'correct': 1,
    },
    {
      'question': 'Which language is used for Flutter?',
      'options': ['Java', 'Kotlin', 'Dart', 'Swift'],
      'correct': 2,
    },
    {
      'question': 'What is a Widget in Flutter?',
      'options': [
        'A database table',
        'A building block of UI',
        'A server request',
        'A type of file',
      ],
      'correct': 1,
    },
    {
      'question': 'Which company developed Flutter?',
      'options': ['Apple', 'Microsoft', 'Google', 'Facebook'],
      'correct': 2,
    },
    {
      'question': 'What is Hot Reload?',
      'options': [
        'Restarting the app',
        'Seeing changes instantly without restart',
        'Deleting the app',
        'Installing updates',
      ],
      'correct': 1,
    },
  ];

  void _checkAnswer(int selectedOption) {
    if (_isAnswered) return;

    setState(() {
      _selectedOption = selectedOption;
      _isAnswered = true;

      if (selectedOption == _questions[_currentQuestion]['correct']) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestion < _questions.length - 1) {
      setState(() {
        _currentQuestion++;
        _selectedOption = null;
        _isAnswered = false;
      });
    } else {
      setState(() {
        _isFinished = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Result screen
    if (_isFinished) {
      return Scaffold(
        appBar: AppBar(title: const Text('Quiz Result')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _score >= 3 ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                ),
                child: Icon(
                  _score >= 3 ? Icons.emoji_events : Icons.sentiment_dissatisfied,
                  size: 60,
                  color: _score >= 3 ? Colors.amber : Colors.red,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                _score >= 3 ? 'Congratulations!' : 'Keep Practicing!',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                'Your Score: $_score / ${_questions.length}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                '${((_score / _questions.length) * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: _score >= 3 ? Colors.green : Colors.red,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to Dashboard'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    _currentQuestion = 0;
                    _score = 0;
                    _selectedOption = null;
                    _isAnswered = false;
                    _isFinished = false;
                  });
                },
                child: const Text('Retry Quiz'),
              ),
            ],
          ),
        ),
      );
    }

    // Quiz screen
    final question = _questions[_currentQuestion];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.timer, size: 20),
            const SizedBox(width: 4),
            Text('10:00'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Progress bar
          LinearProgressIndicator(
            value: (_currentQuestion + 1) / _questions.length,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation(Color(0xFF6C63FF)),
            minHeight: 4,
          ),

          // Question counter
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question ${_currentQuestion + 1}/${_questions.length}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Score: $_score',
                  style: const TextStyle(color: Color(0xFF6C63FF), fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),

          // Question
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C63FF).withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      question['question'],
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, height: 1.5),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Options
                  ...List.generate(4, (index) {
                    final options = question['options'] as List<String>;
                    final isSelected = _selectedOption == index;
                    final isCorrect = index == question['correct'];

                    Color? bgColor;
                    if (_isAnswered) {
                      if (isCorrect) {
                        bgColor = Colors.green.withOpacity(0.1);
                      } else if (isSelected && !isCorrect) {
                        bgColor = Colors.red.withOpacity(0.1);
                      }
                    } else if (isSelected) {
                      bgColor = const Color(0xFF6C63FF).withOpacity(0.1);
                    }

                    Color? borderColor;
                    if (_isAnswered) {
                      if (isCorrect) {
                        borderColor = Colors.green;
                      } else if (isSelected && !isCorrect) {
                        borderColor = Colors.red;
                      }
                    } else if (isSelected) {
                      borderColor = const Color(0xFF6C63FF);
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: () => _checkAnswer(index),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: bgColor ?? Theme.of(context).cardTheme.color,
                            border: Border.all(
                              color: borderColor ?? Colors.grey.withOpacity(0.3),
                              width: borderColor != null ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected
                                      ? borderColor ?? const Color(0xFF6C63FF)
                                      : Colors.grey[200],
                                ),
                                child: Center(
                                  child: Text(
                                    ['A', 'B', 'C', 'D'][index],
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : Colors.grey[700],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  options[index],
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              if (_isAnswered && isCorrect)
                                const Icon(Icons.check_circle, color: Colors.green),
                              if (_isAnswered && isSelected && !isCorrect)
                                const Icon(Icons.cancel, color: Colors.red),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          // Next button
          if (_isAnswered)
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _nextQuestion,
                  child: Text(
                    _currentQuestion < _questions.length - 1 ? 'Next' : 'See Result',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
