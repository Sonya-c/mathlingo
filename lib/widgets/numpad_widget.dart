import 'package:flutter/material.dart';

class Numpad extends StatelessWidget {
  final updateAnswer;
  final clearAnswer;
  final submmitAnswer;

  const Numpad({
    super.key,
    required this.updateAnswer,
    required this.clearAnswer,
    required this.submmitAnswer,
  });

  Widget numpadButton(int index) {
    return FilledButton(
      key: Key("numpad_widget_$index"),
      onPressed: () {
        if (index <= 9) {
          updateAnswer(index.toString());
        } else if (index == 10) {
          clearAnswer();
        } else {
          submmitAnswer();
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          index <= 9 ? Colors.blue : Colors.orange,
        ),
      ),
      child: Text(
        (index <= 9)
            ? index.toString()
            : (index == 10)
                ? "C"
                : "GO",
        style: const TextStyle(fontSize: 25),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 3,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
      childAspectRatio: 1.5,
      children: [
        numpadButton(1),
        numpadButton(2),
        numpadButton(3),
        numpadButton(4),
        numpadButton(5),
        numpadButton(6),
        numpadButton(7),
        numpadButton(8),
        numpadButton(9),
        numpadButton(0),
        numpadButton(10),
        numpadButton(11),
      ],
    );
  }
}
