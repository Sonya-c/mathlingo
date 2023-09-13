import 'package:flutter/material.dart';
import 'package:mathlingo/widgets/question_widget.dart';
import 'package:mathlingo/widgets/ResponsiveContainer.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
        appBar: AppBar(
          title: const Text('Mathlingo'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        children: [Question(num1: 1, num2: 2, op: "+")]);
  }
}
