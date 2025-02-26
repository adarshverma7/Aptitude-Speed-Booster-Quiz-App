class Question {
  final String text; // The question text
  final String answer; // The correct answer
  final List<String> options; // List of options for the question

  Question({
    required this.text,
    required this.answer,
    required this.options,
  });

  // Convert a Question object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'answer': answer,
      'options': options,
    };
  }

  // Create a Question object from a JSON map
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      text: json['text'] ?? 'Unknown',
      answer: json['answer'] ?? 'Unknown',
      options: List<String>.from(json['options'] ?? []),
    );
  }
}