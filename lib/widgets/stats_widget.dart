import 'package:flutter/material.dart';

class Stats extends StatelessWidget {
  const Stats({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: const Column(
        children: [
          Row(
            children: [
              Text(
                "Dificulty: ",
                style: textStyle,
              )
            ],
          ),
          Row(
            children: [Text("Solved problems: ", style: textStyle)],
          ),
          Row(
            children: [Text("Time played: ", style: textStyle)],
          )
        ],
      ),
    );
  }
}
