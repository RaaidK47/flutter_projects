import 'package:flutter/material.dart';
import 'dart:math';

// Actual widget
class DiceRoller extends StatefulWidget{
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

// _ means that this class is Private
// The state, where your variables & logic live
class _DiceRollerState extends State<DiceRoller> {

  var diceNumber = 2;
  final randomizer = Random();
  // Using final so that Random Object is not created Everytime we press the Button
  // This is to improve Memory Usage

  void rollDice() {
    setState(() {
      diceNumber = randomizer.nextInt(6) + 1; // 1–6
    });
    // print("Changing Image...");
  }

  @override
  Widget build(BuildContext context) {
    // Column Widget is used to place widgets vertically
    return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/dice-$diceNumber.png',
              width: 200,
            ),
            const SizedBox(
              height: 30,
            ), //To add Extra Spacing Between Two Widgets
            TextButton(
              onPressed: rollDice, // function pointer, not rollDice(),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                textStyle: TextStyle(fontSize: 28),
              ),
              child: const Text("Roll Dice"),
            ),
          ],
        );
  }
}