import 'package:flutter/material.dart';
import 'package:mathlingo/widgets/question_widget.dart';
import 'package:mathlingo/widgets/ResponsiveContainer.dart';
import '../../controller/game_controller.dart';
import '../../domain/repositories/game_repository.dart';
import '../../domain/use_case/game_usecase.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late GameController _gameController;
  MathProblem _currentProblem = MathProblem(1, 3, "+", 4);

  @override
  void initState() {
    super.initState();
    _gameController = GameController(GameUseCase(GameRepository()));
    _loadProblem();
  }

  void _loadProblem() async {
    _currentProblem = await _gameController.generateProblem();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
        appBar: AppBar(
          title: const Text('Mathlingo'),
        ),
        children: [
          Question(
              num1: _currentProblem.num1,
              num2: _currentProblem.num2,
              op: _currentProblem.op)
        ]);
  }
}
