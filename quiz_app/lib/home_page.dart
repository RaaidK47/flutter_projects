import 'package:flutter/material.dart';

// Actual widget
// Using StatelessWidget, we will handle Button in some other way
class HomePage extends StatelessWidget {
  const HomePage(this.startQuiz , {super.key});

  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/images/quiz-logo.png', 
        width: 200,
        color: const Color.fromARGB(121, 255, 255, 255)),
        const SizedBox(height: 30), //To add Extra Spacing Between Two Widgets

        const SizedBox(height: 30),
        SelectionContainer.disabled(
          child: Text(
            'Learn Flutter the Fun Way!',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        const SizedBox(height: 30),

        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            textStyle: TextStyle(fontSize: 22),
            foregroundColor: Colors.white,
          ),
          onPressed: startQuiz,
          icon: Icon(Icons.arrow_right_alt),
          label: const Text('Start Quiz!'),
        ),
      ],
    );
  }
}
