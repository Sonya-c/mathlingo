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

  int _numQuestions = 1;
  int _correctAnswers = 0;
  int _levelUp = 0;
  Duration _totalTime = const Duration(minutes: 0, seconds: 0);

  MathProblem _question = MathProblem(0, 0, "+", 0);
  List<MathAnswer> _results = [];

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
    int numQuestions = _numQuestions + 1;
    Duration totalTime = Duration(
      minutes: _totalTime.inMinutes + duration.inMinutes,
      seconds: _totalTime.inSeconds + duration.inSeconds,
    );
    int correctAnswers = _correctAnswers + (isCorrect ? 1 : 0);

    if (numQuestions <= 6) {
      _loadProblem();
    } else {
      await _gameSessionController.synchronizeGameSessions(
        GameSession(
          userEmail: _authenticationController.getEmail,
          duration: totalTime,
          correctAnwers: correctAnswers,
          level: _gameController.level.value,
        ),
      );

      var results = await _gameController.getAnswers();
      var levelUp = await _gameController.levelUp();

      setState(() {
        _levelUp = levelUp;
        _results = results;
      });
    }

    setState(() {
      _numQuestions = numQuestions;
      _totalTime = totalTime;
      _correctAnswers = correctAnswers;
    });
  }

  void _resetGame() async {
    setState(() {
      _numQuestions = 1;
      _correctAnswers = 0;
      _totalTime = const Duration(minutes: 0, seconds: 0);
    });
    await _gameController.clearAnswers();
    _loadProblem();
  }

  @override
  Widget build(BuildContext context) {
    return (_numQuestions <= 6
        ? QuestionPage(
            numQuestions: _numQuestions,
            question: _question,
            submmitAnswer: _submmitAnswer,
          )
        : ResultsPage(
            levelUp: _levelUp,
            correctAnswers: _correctAnswers,
            totalTime: _totalTime,
            results: _results,
            resetGame: _resetGame,
          ));
  }
}
