import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import '../models/question.dart';
import 'results_page.dart';

class QuizPage extends StatefulWidget {
  final String quizType;
  final int startRange;
  final int endRange;
  final int numberOfQuestions;

  QuizPage({
    required this.quizType,
    required this.startRange,
    required this.endRange,
    required this.numberOfQuestions,
  });

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final Stopwatch _stopwatch = Stopwatch();
  List<double> timePerQuestion = [];
  final List<int> standardAngles = [0, 30, 45, 60, 90, 120, 135, 150, 180, 210, 225, 240, 270, 300, 315, 330, 360];
  late List<Question> questions;
  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  int incorrectAnswers = 0;
  List<String?> userSelections = [];
  late Timer _timer;
  String _elapsedTime = "00:00.00";

  @override
  void initState() {
    super.initState();
    questions = _generateQuestions();
    if (questions.isEmpty) {
      throw Exception("No questions were generated. Check the quiz type and range.");
    }
    userSelections = List.filled(widget.numberOfQuestions, null);
    _startTimer();
    _stopwatch.start();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        _elapsedTime = _formatTime(_stopwatch.elapsedMilliseconds);
      });
    });
  }

  String _formatTime(int milliseconds) {
    int minutes = (milliseconds / (1000 * 60)).floor();
    int seconds = ((milliseconds % (1000 * 60)) / 1000).floor();
    int millis = (milliseconds % 1000) ~/ 10; // Extract two digits for milliseconds

    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${millis.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _timer.cancel();
    _stopwatch.stop();
    super.dispose();
  }

  List<Question> _generateQuestions() {
    List<Question> generatedQuestions = [];
    final random = Random();

    for (int i = 0; i < widget.numberOfQuestions; i++) {
      int num1 = widget.startRange + random.nextInt(widget.endRange - widget.startRange + 1);
      int num2 = widget.startRange + random.nextInt(widget.endRange - widget.startRange + 1);

      switch (widget.quizType) {
        case "square":
          generatedQuestions.add(Question(
            text: "What is $num1²?",
            answer: "${num1 * num1}",
            options: _generateOptions(num1, (n) => n * n),
          ));
          break;
        case "cube":
          generatedQuestions.add(Question(
            text: "What is $num1³?",
            answer: "${num1 * num1 * num1}",
            options: _generateOptions(num1, (n) => n * n * n),
          ));
          break;
        case "square_root":
          int square = num1 * num1;
          generatedQuestions.add(Question(
            text: "What is √$square?",
            answer: "$num1",
            options: _generateOptions(num1, (n) => n),
          ));
          break;
        case "cube_root":
          int cube = num1 * num1 * num1;
          generatedQuestions.add(Question(
            text: "What is ∛$cube?",
            answer: "$num1",
            options: _generateOptions(num1, (n) => n),
          ));
          break;
        case "table":
          int multiplier = random.nextInt(10) + 1;
          generatedQuestions.add(Question(
            text: "What is $num1 × $multiplier?",
            answer: "${num1 * multiplier}",
            options: _generateOptions(multiplier, (n) => num1 * n),
          ));
          break;
        case "cryptogram":
          String letter = String.fromCharCode(65 + random.nextInt(26));
          int shift = random.nextInt(5) + 1;
          String encryptedLetter = String.fromCharCode((letter.codeUnitAt(0) - 65 + shift) % 26 + 65);
          generatedQuestions.add(Question(
            text: "What letter is $encryptedLetter shifted by $shift?",
            answer: letter,
            options: _generateCryptogramOptions(encryptedLetter, shift),
          ));
          break;
        case "trigonometry":
          int angle = standardAngles[random.nextInt(standardAngles.length)];
          String trigFunction = ["sin", "cos", "tan"][random.nextInt(3)];
          double result = trigFunction == "sin"
              ? sin(angle * pi / 180)
              : trigFunction == "cos"
              ? cos(angle * pi / 180)
              : tan(angle * pi / 180);
          generatedQuestions.add(Question(
            text: "What is $trigFunction($angle°)?",
            answer: result.toStringAsFixed(2),
            options: _generateTrigOptions(angle, trigFunction),
          ));
          break;
        case "addition":
          generatedQuestions.add(Question(
            text: "What is $num1 + $num2?",
            answer: "${num1 + num2}",
            options: _generateOptions([num1, num2], (n1, n2) => n1 + n2),
          ));
          break;
        case "subtraction":
          generatedQuestions.add(Question(
            text: "What is $num1 - $num2?",
            answer: "${num1 - num2}",
            options: _generateOptions([num1, num2], (n1, n2) => n1 - n2),
          ));
          break;
        case "multiplication":
          generatedQuestions.add(Question(
            text: "What is $num1 × $num2?",
            answer: "${num1 * num2}",
            options: _generateOptions([num1, num2], (n1, n2) => n1 * n2),
          ));
          break;
        case "division":
          num2 = num2 == 0 ? 1 : num2; // Avoid division by zero
          generatedQuestions.add(Question(
            text: "What is $num1 ÷ $num2?",
            answer: "${(num1 / num2).toStringAsFixed(2)}",
            options: _generateOptions([num1, num2], (n1, n2) => (n1 / n2).toStringAsFixed(2)),
          ));
          break;
        case "percentage":
          double percentage = random.nextDouble() * 100; // Random percentage between 0 and 100
          generatedQuestions.add(Question(
            text: "What is ${percentage.toStringAsFixed(2)}% of $num1?",
            answer: "${(num1 * percentage / 100).toStringAsFixed(2)}",
            options: _generateOptions([num1, percentage], (n1, p) => (n1 * p / 100).toStringAsFixed(2)),
          ));
          break;
        case "complexity":
          int num3 = widget.startRange + random.nextInt(widget.endRange - widget.startRange + 1);
          generatedQuestions.add(Question(
            text: "What is ($num1 + $num2) × $num3?",
            answer: "${(num1 + num2) * num3}",
            options: _generateOptions([num1 + num2, num3], (n1, n2) => n1 * n2),
          ));
          break;
        case "mixed":
          List<String> types = ["square", "cube", "square_root", "cube_root", "table", "cryptogram", "trigonometry"];
          String randomType = types[random.nextInt(types.length)];
          if (randomType == "trigonometry") {
            int angle = standardAngles[random.nextInt(standardAngles.length)];
            String trigFunction = ["sin", "cos", "tan"][random.nextInt(3)];
            double result = trigFunction == "sin"
                ? sin(angle * pi / 180)
                : trigFunction == "cos"
                ? cos(angle * pi / 180)
                : tan(angle * pi / 180);
            generatedQuestions.add(Question(
              text: "What is $trigFunction($angle°)?",
              answer: result.toStringAsFixed(2),
              options: _generateTrigOptions(angle, trigFunction),
            ));
          } else {
            generatedQuestions.addAll(_generateMixedQuestions(randomType, num1, random));
          }
          break;
        default:
          throw Exception("Invalid quiz type: ${widget.quizType}");
      }
    }

    return generatedQuestions;
  }

  List<String> _generateOptions(dynamic num, dynamic operation) {
    final random = Random();
    final correctAnswer = operation is Function(int)
        ? operation(num).toString()
        : operation(num is int ? num : num[0], num is int ? num : num[1]).toString();
    final options = <String>[correctAnswer];

    while (options.length < 4) {
      dynamic randomNum;
      if (num is int) {
        randomNum = num + random.nextInt(10) - 5;
      } else {
        randomNum = [
          num[0] + random.nextInt(10) - 5,
          num[1] + random.nextInt(10) - 5,
        ];
      }

      String option;
      if (operation is Function(int)) {
        option = operation(randomNum).toString();
      } else {
        option = operation(randomNum[0], randomNum[1]).toString();
      }

      if (!options.contains(option)) {
        options.add(option);
      }
    }

    options.shuffle();
    return options;
  }

  List<String> _generateCryptogramOptions(String encryptedLetter, int shift) {
    final random = Random();
    final correctAnswer = String.fromCharCode((encryptedLetter.codeUnitAt(0) - 65 - shift + 26) % 26 + 65);
    final options = <String>[correctAnswer];

    while (options.length < 4) {
      int randomShift = random.nextInt(5) + 1;
      String option = String.fromCharCode((encryptedLetter.codeUnitAt(0) - 65 - randomShift + 26) % 26 + 65);
      if (!options.contains(option)) {
        options.add(option);
      }
    }

    options.shuffle();
    return options;
  }

  List<String> _generateTrigOptions(int angle, String trigFunction) {
    final random = Random();
    final correctAnswer = trigFunction == "sin"
        ? sin(angle * pi / 180)
        : trigFunction == "cos"
        ? cos(angle * pi / 180)
        : tan(angle * pi / 180);
    final options = <String>[correctAnswer.toStringAsFixed(2)];

    while (options.length < 4) {
      int randomAngle = standardAngles[random.nextInt(standardAngles.length)];
      double randomResult = trigFunction == "sin"
          ? sin(randomAngle * pi / 180)
          : trigFunction == "cos"
          ? cos(randomAngle * pi / 180)
          : tan(randomAngle * pi / 180);
      String option = randomResult.toStringAsFixed(2);
      if (!options.contains(option)) {
        options.add(option);
      }
    }

    options.shuffle();
    return options;
  }

  List<Question> _generateMixedQuestions(String type, int num, Random random) {
    List<Question> mixedQuestions = [];
    switch (type) {
      case "square":
        mixedQuestions.add(Question(
          text: "What is $num²?",
          answer: "${num * num}",
          options: _generateOptions(num, (n) => n * n),
        ));
        break;
      case "cube":
        mixedQuestions.add(Question(
          text: "What is $num³?",
          answer: "${num * num * num}",
          options: _generateOptions(num, (n) => n * n * n),
        ));
        break;
      case "square_root":
        int square = num * num;
        mixedQuestions.add(Question(
          text: "What is √$square?",
          answer: "$num",
          options: _generateOptions(num, (n) => n),
        ));
        break;
      case "cube_root":
        int cube = num * num * num;
        mixedQuestions.add(Question(
          text: "What is ∛$cube?",
          answer: "$num",
          options: _generateOptions(num, (n) => n),
        ));
        break;
      case "table":
        int multiplier = random.nextInt(10) + 1;
        mixedQuestions.add(Question(
          text: "What is $num × $multiplier?",
          answer: "${num * multiplier}",
          options: _generateOptions(multiplier, (n) => num * n),
        ));
        break;
      case "cryptogram":
        String letter = String.fromCharCode(65 + random.nextInt(26));
        int shift = random.nextInt(5) + 1;
        String encryptedLetter = String.fromCharCode((letter.codeUnitAt(0) - 65 + shift) % 26 + 65);
        mixedQuestions.add(Question(
          text: "What letter is $encryptedLetter shifted by $shift?",
          answer: letter,
          options: _generateCryptogramOptions(encryptedLetter, shift),
        ));
        break;
    }
    return mixedQuestions;
  }

  void _checkAnswer(String? selectedOption) {
    setState(() {
      _stopwatch.stop();
      timePerQuestion.add(_stopwatch.elapsedMilliseconds / 1000); // Store time in seconds as double

      userSelections[currentQuestionIndex] = selectedOption;
      if (selectedOption == questions[currentQuestionIndex].answer) {
        correctAnswers++;
      } else {
        incorrectAnswers++;
      }

      // Cancel the current timer before moving to the next question
      _timer.cancel();

      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        _stopwatch.reset(); // Reset the stopwatch
        _stopwatch.start(); // Start the stopwatch again
        _startTimer(); // Start a new timer
      } else {
        // No more questions, navigate to the results page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsPage(
              questions: questions,
              userSelections: userSelections,
              correctAnswers: correctAnswers,
              timePerQuestion: timePerQuestion,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Top Bar: Quiz Category, Progress, and Timer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Quiz Category
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.quizType,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple[800],
                    ),
                  ),
                ),
                // Progress Indicator
                Text(
                  "Question ${currentQuestionIndex + 1}/${widget.numberOfQuestions}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple[800],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Correct, Timer, and Incorrect Counts
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Correct: $correctAnswers",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.timer, // Clock icon
                        color: Colors.purple[800],
                        size: 20,
                      ),
                      SizedBox(width: 8), // Spacing between icon and text
                      Text(
                        _elapsedTime, // Display elapsed time
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple[800],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Incorrect: $incorrectAnswers",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[800],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Question Text
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Text(
                questions[currentQuestionIndex].text,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple[800],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Answer Options
            Expanded(
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  children: questions[currentQuestionIndex].options.map((option) {
                    bool isSelected = userSelections[currentQuestionIndex] == option;
                    bool isCorrect = option == questions[currentQuestionIndex].answer;
                    bool showFeedback = userSelections[currentQuestionIndex] != null;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        onPressed: showFeedback ? null : () => _checkAnswer(option),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: showFeedback
                              ? (isCorrect
                              ? Colors.green[50] // Highlight correct answer
                              : (isSelected
                              ? Colors.orange[50] // Highlight incorrect answer
                              : Colors.white))
                              : Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: showFeedback
                                  ? (isCorrect
                                  ? Colors.green
                                  : (isSelected ? Colors.orange : Colors.purple[200]!))
                                  : Colors.purple[200]!,
                              width: 1,
                            ),
                          ),
                          elevation: 2,
                          shadowColor: Colors.purple.withOpacity(0.1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              option,
                              style: TextStyle(
                                fontSize: 18,
                                color: showFeedback
                                    ? (isCorrect
                                    ? Colors.green[800]
                                    : (isSelected ? Colors.orange[800] : Colors.purple[800]))
                                    : Colors.purple[800],
                              ),
                            ),
                            if (showFeedback && (isSelected || isCorrect)) ...[
                              SizedBox(width: 8),
                              Icon(
                                isCorrect ? Icons.check : Icons.close,
                                color: isCorrect ? Colors.green : Colors.orange,
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}