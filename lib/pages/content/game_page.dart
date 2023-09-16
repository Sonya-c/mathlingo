import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mathlingo/widgets/responsive_container.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final random = Random();

  String answer = "";

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
    bool isCorrect = random.nextBool();
    MaterialColor acentColor = isCorrect ? Colors.green : Colors.red;

    showModalBottomSheet(
      context: context,
      elevation: 10,
      backgroundColor: acentColor[200],
      builder: (context) => SizedBox(
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
                      answer,
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      appBar: AppBar(
        title: const Text('Quiz: question 1 /10'),
      ),
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "1 + 1 = ",
                style: TextStyle(fontSize: 50),
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
