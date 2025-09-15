import 'package:flutter/material.dart';
import 'package:quiz_app/home_page.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/data/questions.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {

  List<String> selectedAnswers = [];

  Widget? activeScreen;

  @override
  // initState() is executed once after creation of class object
  // It also executes before the execution of build() method
  void initState() {
    activeScreen = HomePage(switchScreen);
    super.initState();
  }

  void chooseAnswer(String answer){
    selectedAnswers.add(answer);

    // import 'package:quiz_app/data/questions.dart';
    if(selectedAnswers.length == questions.length ){
      // The Questions are Completed
      // Temporarily we Switch to HomePage

      selectedAnswers = []; //Resetting the List

      setState(() {
      activeScreen = HomePage(switchScreen);
    });
    }
  }

  void switchScreen(){
    // setState() function reexecutes the build() method below, 
    // so that the UI refreshes to execute the changes caused by state change
    setState(() {
      activeScreen = QuestionsScreen(onSelectAnswer: chooseAnswer);
    });
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.deepPurple, Colors.indigo],
            ),
          ),
          child: Center(child: activeScreen),
        ),
      ),
    );
  }
}
