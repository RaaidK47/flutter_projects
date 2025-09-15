import 'package:flutter/material.dart';
import 'package:quiz_app/answer_button.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex = 0;

  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);

    setState(() {
      // currentQuestionIndex = currentQuestionIndex + 1;
      // currentQuestionIndex += 1;
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(context) {
    var currentQuestion = questions[currentQuestionIndex];

    return SizedBox(
      width: double.infinity,
      child: Container(
        // We Wrap Column inside a Container and Add Margin to have some
        // horizontal space between button ends and boundary
        margin: EdgeInsets.all(50),
        child: Column(
          //Center the Column Widgets Vertically
          mainAxisAlignment: MainAxisAlignment.center,
          //Elements in Column are Stretched Horizontally as wide a possible
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            Center(
              child: Text(
                currentQuestion.text,
                style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 30),

            // Function inside map() will be applied to all elements of list `answers`
            ...currentQuestion.getShuffledAnswers().map((item) {
              return AnswerButton(
                answerText: item, 
                onTap: () {
                  answerQuestion(item);
              });
            }),
          ],
        ),
      ),
    );
  }
}
