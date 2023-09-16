import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathlingo/controller/authentication_controller.dart';
import 'package:mathlingo/widgets/stats_widget.dart';
import '../../widgets/center_container.dart';
import 'game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthenticationController authenticationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      appBar: AppBar(
        title: const Text('Mathlingo'),
        actions: [
          IconButton(
            onPressed: () async {
              await authenticationController.logOut();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      children: [
        const Stats(),
        const SizedBox(
          height: 20,
        ),
        FilledButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const GamePage()));
            },
            child: const Text("Play"))
      ],
    );
  }
}
