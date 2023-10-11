import 'package:flutter/material.dart';

class Numpad extends StatelessWidget {
  final updateAnswer;
  final clearAnswer;
  final submmitAnswer;
  final bool disabled;

  const Numpad({
    super.key,
    required this.updateAnswer,
    required this.clearAnswer,
    required this.submmitAnswer,
    this.disabled = false,
  });

  Widget numpadButton(int index) {
    return FilledButton(
      key: Key("numpad_widget_$index"),
      onPressed: () {
        if (!disabled) {
          if (index <= 9) {
            updateAnswer(index.toString());
          } else if (index == 10) {
            clearAnswer();
          } else {
            submmitAnswer();
          }
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          disabled
              ? Colors.grey
              : index <= 9
                  ? Colors.blue
                  : Colors.orange,
        ),
      ),
      child: Text(
        (index <= 9)
            ? index.toString()
            : (index == 10)
                ? "C"
                : "GO",
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /*List options = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
      [0, 10, 11]
    ];*/
    List options = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 10, 11];
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1.5,
      children: options.map((index) => numpadButton(index)).toList(),
    );

    /*return Column(
        children: options
            .map((row) => Row(
                  children: List<Widget>.from(
                      row.map((index) => numpadButton(index))),
                ))
            .toList());*/
  }
}
