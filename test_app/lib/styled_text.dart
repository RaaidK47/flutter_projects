import 'package:flutter/material.dart';


class StyledText extends StatelessWidget{

  // Step 1: Add a class variable (final = set once, never changes)
  final String text;

  // Step 2: Accept the text via constructor and assign to the variable
  const StyledText(this.text, {super.key});

  
  @override //Overriding the method that is expected by StatelessWidget Class
  Widget build(BuildContext context) {
    return Text(
          text, // Step 3: Use it here instead of hard-coded string
          style: TextStyle(
          fontSize: 30,
          color: Color.fromARGB(248, 255, 82, 82),
          ),
    );
  }
}