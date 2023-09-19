import 'package:flutter/material.dart';

class PanelWidget extends StatelessWidget {
  final int num1, num2;
  final String op, answer;

  const PanelWidget({
    super.key,
    required this.num1,
    required this.num2,
    required this.op,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            key: const Key("panel_widget_question"),
            "$num1 $op $num2 =",
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
              key: const Key("panel_widget_answer"),
              answer.isEmpty ? "?" : answer,
              style: const TextStyle(fontSize: 50),
            ),
          )
        ],
      ),
    );
  }
}
