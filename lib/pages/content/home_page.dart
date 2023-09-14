import 'package:flutter/material.dart';
import 'package:mathlingo/widgets/stats_widget.dart';
import '../../widgets/ResponsiveContainer.dart';
import 'game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      children: [
        const Stats(),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const GamePage()));
            },
            child: const Text("Play"))
      ],
    );
  }
}
