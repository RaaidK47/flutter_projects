import 'package:flutter/material.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary({super.key, required this.summaryData});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: SingleChildScrollView(
        child: Column(
          // We convert List of Maps to List of Widgets
          children: summaryData.map((data) {
            final isCorrect = data['user_answer'] == data['correct_answer'];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start, // To make Circles place on Top of Row
              children: [
                // First Child of Row is Question Number
                // Performing Type Casting below
                CircleAvatar(
                  backgroundColor: isCorrect ? Colors.green : Colors.red, // conditional color
                  radius: 20, // Size of the circle
                  child: Text(
                    ((data['question_index'] as int) + 1).toString(),
                    style: const TextStyle(
                      color: Colors.white, // Text color
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                // Text(((data['question_index'] as int) + 1).toString()),

                SizedBox(width: 10,),

                //Second Child of Row is a Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((data['question_text'] as String),textAlign: TextAlign.start, style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255), fontSize: 16),),
                      SizedBox(height: 5),
                      Text((data['user_answer'] as String),textAlign: TextAlign.start, style: TextStyle(color: const Color.fromARGB(255, 255, 19, 2), fontSize: 14, fontFamily: 'Tahoma'),),
                      SizedBox(height: 5),
                      Text((data['correct_answer'] as String),textAlign: TextAlign.start, style: TextStyle(color: const Color.fromARGB(255, 24, 255, 113), fontSize: 14, fontFamily: 'Tahoma'),),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
