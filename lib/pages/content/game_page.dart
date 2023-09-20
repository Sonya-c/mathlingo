import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathlingo/widgets/correct_ans_modal.dart';
import 'package:mathlingo/widgets/numpad_widget.dart';
import 'package:mathlingo/widgets/panel_widget.dart';
import 'package:mathlingo/widgets/responsive_container.dart';
import '../../controller/game_controller.dart';
import '../../domain/repositories/game_repository.dart';
import '../../domain/use_case/game_usecase.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final _gameController = GameController(GameUseCase(GameRepository()));
  final Stopwatch stopwatch = Stopwatch();

  String answer = "";
  int numQuestions = 1;
  int correctAnswers = 0;
  List<MathAnswer> results = [];
  Duration totalTime = const Duration(minutes: 0, seconds: 0);
  MathProblem _question = MathProblem(0, 0, "+", 0);

  @override
  void initState() {
    super.initState();
    _loadProblem();
  }

  void _loadProblem() async {
    MathProblem question = await _gameController.generateProblem();
    setState(() {
      _question = question;
      stopwatch.reset();
      stopwatch.start();
    });
  }

  _updateAnswer(String num) {
    setState(() {
      answer += num;
    });
  }

  _clearAnswer() {
    setState(() {
      answer = "";
    });
  }

  _submmitAnswer() async {
    if (answer.isEmpty) {
      Get.snackbar(
        "Missing answer!",
        "You must enter an answer",
        snackPosition: SnackPosition.TOP,
      );
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

    setState(() {
      totalTime = totalTime + stopwatch.elapsed;
      numQuestions++;
      if (isCorrect) {
        correctAnswers++;
      }
    });

    if (numQuestions <= 6) {
      _loadProblem();
      _clearAnswer();
    } else {
      results = await _gameController.getAnswers();
      _gameController.clearAnswers();
    }
  }

  void _resetGame() {
    _loadProblem();

    setState(() {
      numQuestions = 1;
      answer = "";
      correctAnswers = 0;
      totalTime = const Duration(minutes: 0, seconds: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      appBar: AppBar(
        title: Text(
          'Quiz: question $numQuestions/6',
          key: const Key("game_page_appbar_title"),
        ),
      ),
      children: (numQuestions <= 6)
          ? ([
              PanelWidget(
                question: _question.toString(),
                answer: answer,
              ),
              const SizedBox(
                height: 80,
              ),
              Numpad(
                updateAnswer: _updateAnswer,
                clearAnswer: _clearAnswer,
                submmitAnswer: _submmitAnswer,
              )
            ])
          : ([
              const Text(
                "Results",
                style: TextStyle(fontSize: 50),
              ),
              const SizedBox(
                height: 25,
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
                key: const Key("game_page_resetgame_button"),
                onPressed: () {
                  _resetGame();
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
                  Get.back();
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
            ]),
    );
  }
}
