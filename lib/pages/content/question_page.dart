import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathlingo/controller/game_controller.dart';
import 'package:mathlingo/domain/models/math_problem.dart';
import 'package:mathlingo/widgets/correct_ans_modal.dart';
import 'package:mathlingo/widgets/numpad_widget.dart';
import 'package:mathlingo/widgets/panel_widget.dart';
import 'package:mathlingo/widgets/responsive_container.dart';

class QuestionPage extends StatefulWidget {
  final int numQuestions;
  final MathProblem question;
  final submmitAnswer;
  final finishGame;

  const QuestionPage({
    super.key,
    required this.numQuestions,
    required this.question,
    required this.submmitAnswer,
    required this.finishGame,
  });

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  String answer = "";
  bool pause = false;

  final Stopwatch stopwatch = Stopwatch();
  final GameController _gameController = Get.find();

  @override
  void initState() {
    super.initState();
    stopwatch.start();
    _clearAnswer();
  }

  _updateAnswer(String num) {
    setState(() {
      answer += num;
    });
  }

  _clearAnswer() {
    if (mounted) {
      setState(() => answer = "");
    }
  }

  _submmitAnswer() async {
    if (answer.isEmpty) {
      Get.snackbar("Missing answer!", "You must enter an answer");
      return;
    }

    stopwatch.stop();

    bool isCorrect = await _gameController.verifyAnswer(
      int.parse(answer),
      stopwatch.elapsed,
    );

    String correctAnswer = (await _gameController.getAnswer()).toString();

    // ignore: use_build_context_synchronously
    await showModalBottomSheet(
      context: context,
      elevation: 10,
      // backgroundColor: acentColor[200],
      builder: (context) => CorrectAnswer(
        isCorrect: isCorrect,
        correctAnswer: correctAnswer,
        answer: answer,
        time: stopwatch.elapsed,
      ),
    );

    await widget.submmitAnswer(stopwatch.elapsed, isCorrect);

    _clearAnswer();
    stopwatch.reset();
    stopwatch.start();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                pause = !pause;

                if (pause) {
                  stopwatch.stop();
                } else {
                  stopwatch.start();
                }
              });
            },
            icon: pause
                ? const Icon(Icons.play_arrow_sharp)
                : const Icon(Icons.pause),
          ),
          Text(
            "Quiz: Question ${widget.numQuestions}/6",
            key: const Key("game_page_appbar_title"),
            style: const TextStyle(fontSize: 20),
          ),
          IconButton(
              onPressed: () {
                Get.defaultDialog(
                  title: "Are you sure?",
                  middleText:
                      "Are you sure you want to finish this session? (this answer won't be evaluated)",
                  textConfirm: "Yes, finish session",
                  textCancel: "No, keep playing",
                  barrierDismissible: false,
                  radius: 10,
                  titlePadding: const EdgeInsets.all(10),
                  contentPadding: const EdgeInsets.all(10),
                  buttonColor: Colors.red,
                  onConfirm: () {
                    widget.finishGame();
                    Get.back();
                  },
                );
              },
              icon: const Icon(Icons.send)),
        ],
      ),
      const SizedBox(height: 25),
      Blur(
        blur: pause ? 10 : -1,
        colorOpacity: 0,
        blurColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: PanelWidget(
            question: widget.question.toString(),
            answer: answer,
          ),
        ),
      ),
      const SizedBox(
        height: 25,
      ),
      Numpad(
        updateAnswer: _updateAnswer,
        clearAnswer: _clearAnswer,
        submmitAnswer: _submmitAnswer,
        disabled: pause,
      ),
    ]);
  }
}
