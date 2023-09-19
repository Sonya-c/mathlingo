import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mathlingo/widgets/correct_ans_modal.dart';
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
  final random = Random();

  String answer = "";

  final _gameController = GameController(GameUseCase(GameRepository()));

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

  _submmitAnswer(BuildContext context) {
    // TODO: check if answer if correct
    bool isCorrect = random.nextBool();

    showModalBottomSheet(
      context: context,
      elevation: 10,
      // backgroundColor: acentColor[200],
      builder: (context) => CorrectAnswer(
        isCorrect: isCorrect,
        answer: answer,
      ),
    );
    // TODO: change answer/total answer review
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      appBar: AppBar(
        title: const Text('Quiz: question 1/10'),
      ),
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "${_question.num1} ${_question.op} ${_question.num2} =",
                style: const TextStyle(fontSize: 50),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.orange,
                    width: 3,
                  ),
                ),
                child: Text(
                  answer.isEmpty ? "?" : answer,
                  style: const TextStyle(fontSize: 50),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 80,
        ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 1.5,
          ),
          itemCount: 12,
          itemBuilder: (context, index) {
            return FilledButton(
              key: Key("numpad_keyboad_$index"),
              onPressed: () {
                if (index <= 9) {
                  _updateAnswer(index.toString());
                } else if (index == 10) {
                  _clearAnswer();
                } else {
                  _submmitAnswer(context);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    (index <= 10) ? Colors.blue : Colors.orange),
              ),
              child: Text(
                (index <= 9)
                    ? index.toString()
                    : (index == 10)
                        ? "c"
                        : "GO",
                style: const TextStyle(fontSize: 25),
              ),
            );
          },
        ),
      ],
    );
  }
}
