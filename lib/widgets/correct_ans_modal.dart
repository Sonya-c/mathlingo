import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CorrectAnswer extends StatelessWidget {
  final bool isCorrect;
  final String answer, correctAnswer;
  final Duration time;

  const CorrectAnswer({
    super.key,
    required this.isCorrect,
    required this.answer,
    required this.correctAnswer,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    MaterialColor acentColor = isCorrect ? Colors.green : Colors.red;

    return SizedBox(
      height: 250,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isCorrect ? "Correct" : "Incorrect",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: acentColor[900]),
              ),
              const SizedBox(height: 10),
              Text(
                "Time: ${time.inMinutes}:${time.inSeconds}",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: acentColor[800]),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    "Correct answer: ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: acentColor[800]),
                  ),
                  Text(
                    correctAnswer,
                    style: TextStyle(fontSize: 20, color: acentColor[800]),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Your answer: ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: acentColor[800]),
                  ),
                  Text(
                    answer,
                    style: TextStyle(fontSize: 20, color: acentColor[800]),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              FilledButton(
                style: ButtonStyle(
                  padding: const MaterialStatePropertyAll(
                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                  ),
                  backgroundColor: MaterialStatePropertyAll(acentColor[800]),
                ),
                onPressed: () {
                  Get.back(); // close
                },
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 25),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
