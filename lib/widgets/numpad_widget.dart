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

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
          key: Key("numpad_widget_$index"),
          onPressed: () {
            if (index <= 9) {
              updateAnswer(index.toString());
            } else if (index == 10) {
              clearAnswer();
            } else {
              submmitAnswer(context);
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
    );
  }
}
