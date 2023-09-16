import 'package:flutter/material.dart';

import 'package:mathlingo/widgets/responsive_container.dart';

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
        title: const Text('Quiz: question 1 /10'),
      ),
      children: [
        Row(
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
              child: const Text(
                "?",
                style: TextStyle(fontSize: 50),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: 12,
          itemBuilder: (context, index) {
            return FilledButton(
              onPressed: () {},
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
