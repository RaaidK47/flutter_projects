import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen( {super.key, required this.choosenAnswers, required this.onRestart});

  final void Function() onRestart;

  final List<String> choosenAnswers;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < choosenAnswers.length; i++) {
      // We are adding a Map in summary
      summary.add({
        'question_index': i,
        'question_text': questions[i].text,
        // First Answers in Questions List is correct
        'correct_answer': questions[i].answers[0],
        'user_answer': choosenAnswers[i],
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData
        .where((item) => item['correct_answer'] == item['user_answer'])
        .length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        // We Wrap Column inside a Container and Add Margin to have some
        // horizontal space between its contents and boundary
        margin: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You answered $numCorrectQuestions out of $numTotalQuestions questions correctly",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 30),
            QuestionsSummary(summaryData: summaryData),
            const SizedBox(height: 30),
            
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                textStyle: TextStyle(fontSize: 20),
                foregroundColor: Colors.white,
              ),
              onPressed: onRestart,
              icon: Icon(Icons.refresh),
              label: const Text('Restart Quiz!'),
            ),
          ],
        ),
      ),
    );
  }
}
