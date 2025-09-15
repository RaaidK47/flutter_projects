import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  // Receiving Arguments as Named Arguments
  // `reuired` is used to Make Sure that named Arguments are received
  // By default, named arguments are Optional
  const AnswerButton({
    super.key,
    required this.answerText,
    required this.onTap,
  });

  final String answerText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10), // 👈 outside spacing
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 58, 18, 71),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ), // inside padding
          textStyle: TextStyle(fontSize: 16)
        ),
        child: Text(answerText, textAlign: TextAlign.center),
      ),
    );
  }
}
