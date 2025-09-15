class QuizQuestion {
  const QuizQuestion(this.text, this.answers);

  final String text;
  final List<String> answers;

  List<String> getShuffledAnswers(){
    // List.of() create a New Copy of List based on List Passed in it

    final shuffledList = List.of(answers);

    // Calling .shuffle() modify the List in Memory
    // It doesn't return a List 
    shuffledList.shuffle();

    return shuffledList;
  }
}