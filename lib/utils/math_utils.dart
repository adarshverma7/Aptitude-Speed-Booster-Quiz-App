import 'dart:math';
import '../models/question.dart';

class MathUtils {
  static List<Question> generateQuestions({
    required String category,
    required int numberOfQuestions,
    required int rangeStart,
    required int rangeEnd,
  }) {
    List<Question> questions = [];
    final random = Random();

    for (int i = 0; i < numberOfQuestions; i++) {
      int num = rangeStart + random.nextInt(rangeEnd - rangeStart + 1);
      String questionText;
      String correctAnswer;
      List<String> options;

      if (category == "square") {
        questionText = "What is $num²?";
        correctAnswer = "${num * num}";
        options = _generateOptions(num, (n) => n * n);
      } else if (category == "cube") {
        questionText = "What is $num³?";
        correctAnswer = "${num * num * num}";
        options = _generateOptions(num, (n) => n * n * n);
      } else if (category == "alphabet") {
        String letter = String.fromCharCode(64 + num);
        questionText = "What is the position of '$letter' in the alphabet?";
        correctAnswer = "$num";
        options = _generateAlphabetOptions(num);
      } else {
        continue;
      }

      questions.add(Question(
        text: questionText,
        answer: correctAnswer,
        options: options,
      ));
    }
    return questions;
  }

  static List<String> _generateOptions(int num, int Function(int) operation) {
    final random = Random();
    final correctAnswer = operation(num).toString();
    final options = <String>[correctAnswer];

    while (options.length < 4) {
      int randomNum = num + random.nextInt(10) - 5;
      if (randomNum != num) {
        String option = operation(randomNum).toString();
        if (!options.contains(option)) {
          options.add(option);
        }
      }
    }

    options.shuffle();
    return options;
  }

  static List<String> _generateAlphabetOptions(int correctPosition) {
    final random = Random();
    final correctLetter = String.fromCharCode(64 + correctPosition);
    final options = <String>[correctPosition.toString()];

    while (options.length < 4) {
      int randomPos = 1 + random.nextInt(26);
      if (randomPos != correctPosition) {
        String option = randomPos.toString();
        if (!options.contains(option)) {
          options.add(option);
        }
      }
    }

    options.shuffle();
    return options;
  }
}