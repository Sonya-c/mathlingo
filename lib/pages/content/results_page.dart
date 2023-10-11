import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathlingo/domain/models/game_answers.dart';
import 'package:mathlingo/widgets/responsive_container.dart';

class ResultsPage extends StatelessWidget {
  final int levelUp;
  final int correctAnswers;
  final Duration totalTime;
  final List<MathAnswer> results;
  final resetGame;

  const ResultsPage({
    super.key,
    required this.levelUp,
    required this.correctAnswers,
    required this.totalTime,
    required this.results,
    required this.resetGame,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(children: [
      Text(
        "Results $levelUp",
        style: const TextStyle(fontSize: 50),
      ),
      const SizedBox(
        height: 25,
      ),
      Text(
        levelUp == 1
            ? "You have level up!"
            : levelUp == 0
                ? "Well done, keep praticing"
                : "You have level down :'c",
        style: const TextStyle(
          fontSize: 25,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        "Correct answers $correctAnswers/6",
        style: const TextStyle(fontSize: 25),
      ),
      const SizedBox(
        height: 5,
      ),
      Text(
        "Total time ${totalTime.inMinutes}:${totalTime.inSeconds}",
        style: const TextStyle(fontSize: 25),
      ),
      const SizedBox(
        height: 25,
      ),
      Column(
        mainAxisSize: MainAxisSize.max,
        children: results
            .map(
              (result) => Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      result.mathProblem.toString() +
                          result.mathProblem.answer.toString(),
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                      child: Text(
                    result.isCorrect ? "Correct" : "Incorrect",
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  )),
                  Expanded(
                      child: Text(
                    "Time ${result.duration.inMinutes}:${result.duration.inSeconds}",
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
            )
            .toList(),
      ),
      const SizedBox(
        height: 25,
      ),
      FilledButton(
        key: const Key("game_pageresetgame_button"),
        onPressed: () {
          resetGame();
        },
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            Colors.orange,
          ),
          padding: MaterialStatePropertyAll(
            EdgeInsets.fromLTRB(30, 15, 30, 15),
          ),
        ),
        child: const Text(
          "Play again",
          style: TextStyle(fontSize: 20),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      OutlinedButton(
        key: const Key("game_page_returnhome_button"),
        onPressed: () {
          Get.back(result: true);
        },
        style: const ButtonStyle(
          padding: MaterialStatePropertyAll(
            EdgeInsets.fromLTRB(30, 15, 30, 15),
          ),
        ),
        child: const Text(
          "Go to home",
          style: TextStyle(fontSize: 20),
        ),
      )
    ]);
  }
}
