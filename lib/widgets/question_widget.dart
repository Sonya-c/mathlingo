import 'package:flutter/material.dart';

class Question extends StatefulWidget {
  final int num1, num2;
  final String op;

  const Question(
      {super.key, required this.num1, required this.num2, required this.op});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  Widget _numberBox(String content) {
    return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 187, 215, 230),
          border: Border.all(
              color: const Color.fromARGB(255, 99, 145, 170), width: 2),
        ),
        child: Text(
          content,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Question # "),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _numberBox(widget.num1.toString()),
            _numberBox(widget.op),
            _numberBox(widget.num2.toString()),
            _numberBox("="),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Form(
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Answer',
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        FilledButton(onPressed: () {}, child: Text("Submit"))
      ],
    );
  }
}
