import 'package:flutter/material.dart';
import 'package:test_app/dice_roller.dart';
// import 'package:test_app/styled_text.dart';

var startAlignment = Alignment.topLeft;
var endAlignment = Alignment.bottomRight;

class GrandientContainer extends StatelessWidget {
  const GrandientContainer(this.color1, this.color2, {super.key});

  // An Alternate Constructor Function with Predefined Colors
  const GrandientContainer.purple({super.key})
    : color1 = Colors.deepPurple,
      color2 = Colors.indigo;

  final Color color1;
  final Color color2;


  @override //Overriding the method that is expected by StatelessWidget Class
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: startAlignment,
          end: endAlignment,
          colors: [
            color1,
            color2,
          ],
        ),
      ),
      child: Center(
        child: DiceRoller(),
      ),
    );
  }
}
