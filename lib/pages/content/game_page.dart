import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathlingo/controller/game_session_controller.dart';
import 'package:mathlingo/domain/models/game_session.dart';
import 'package:mathlingo/pages/content/question_page.dart';
import 'package:mathlingo/pages/content/results_page.dart';
import '../../controller/authentication_controller.dart';
import '../../controller/game_controller.dart';
import '../../domain/models/game_answers.dart';
import '../../domain/models/math_problem.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final GameController _gameController = Get.find();
  final AuthenticationController _authenticationController = Get.find();
  final GameSessionController _gameSessionController = Get.find();

  int numQuestions = 1;
  int correctAnswers = 0;
  int levelUp = 0;
  Duration totalTime = const Duration(minutes: 0, seconds: 0);

  MathProblem _question = MathProblem(0, 0, "+", 0);
  List<MathAnswer> results = [];

  @override
  void initState() {
    super.initState();
    _gameController.clearAnswers();
    _loadProblem();
  }

  void _loadProblem() async {
    MathProblem question = await _gameController.generateProblem();
    setState(() {
      _question = question;
    });
  }

  _submmitAnswer(Duration duration, bool isCorrect) async {
    setState(() {
      totalTime = Duration(
        minutes: totalTime.inMinutes + duration.inMinutes,
        seconds: totalTime.inSeconds + duration.inSeconds,
      );
      numQuestions++;
      if (isCorrect) {
        correctAnswers++;
      }
    });

    if (numQuestions <= 6) {
      _loadProblem();
    } else {
      _gameSessionController.addGameSession(
        GameSession(
          userEmail: _authenticationController.getEmail,
          duration: totalTime,
          correctAnwers: correctAnswers,
          level: _gameController.level.value,
        ),
      );

      results = await _gameController.getAnswers();
      levelUp = await _gameController.levelUp();

      await _gameController.clearAnswers();
    }
  }

  void _resetGame() {
    setState(() {
      numQuestions = 1;
      correctAnswers = 0;
      totalTime = const Duration(minutes: 0, seconds: 0);
    });

    _loadProblem();
  }

  @override
  Widget build(BuildContext context) {
    return (numQuestions <= 6
        ? QuestionPage(
            numQuestions: numQuestions,
            question: _question,
            submmitAnswer: _submmitAnswer,
          )
        : ResultsPage(
            levelUp: levelUp,
            correctAnswers: correctAnswers,
            totalTime: totalTime,
            results: results,
            resetGame: _resetGame,
          ));
  }
}
