import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:basic_quiz_app/data/questions.dart';
import 'package:basic_quiz_app/questions_summary/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen(
      {super.key, required this.chosenAnswers, required this.onRestartQuiz});

  final List<String> chosenAnswers;
  final void Function() onRestartQuiz;

  List<Map<String, Object>> get summaryData {
    // List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i],
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final numberOfTotalQuestions = questions.length;
    final numberOfCorrectAnswers = summaryData
        .where((data) => data['correct_answer'] == data['user_answer'])
        .length;
    // final numberOfCorrectAnswers = summaryData.where((data) {
    //   return data['correct_answer'] == data['user_answer'];
    // }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'You answered $numberOfCorrectAnswers out of $numberOfTotalQuestions questions Correctly!',
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 201, 153, 251),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionsSummary(summaryData),
            const SizedBox(
              height: 10,
            ),
            TextButton.icon(
              onPressed: onRestartQuiz,
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              label: const Text('Restart Quiz!'),
              icon: const Icon(Icons.refresh_outlined),
            )
          ],
        ),
      ),
    );
  }
}

// Text(((data['question_index'] as int) + 1).toString()),