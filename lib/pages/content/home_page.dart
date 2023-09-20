import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:mathlingo/controller/authentication_controller.dart';
import 'package:mathlingo/controller/game_controller.dart';
import '../../widgets/responsive_container.dart';
import 'game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthenticationController authenticationController = Get.find();
  GameController gameController = Get.find();
  int level = 0;

  @override
  void initState() {
    super.initState();
    _getLevel();
  }

  _getLevel() async {
    level = await gameController.getLevel();
    setState(() {
      level = level;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      appBar: AppBar(
        title: const Text('Mathlingo'),
        actions: [
          IconButton(
            key: const Key("home_page_retun_button"),
            onPressed: () async {
              await authenticationController.logOut();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      children: [
        Text("Level $level"),
        FilledButton(
          key: const Key("home_page_play_button"),
          onPressed: () async {
            var response = await Get.to(() => const GamePage());
            logInfo(response);
            if (response) await _getLevel();
          },
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Colors.orange,
            ),
            padding: MaterialStatePropertyAll(EdgeInsets.fromLTRB(
              30,
              15,
              30,
              15,
            )),
          ),
          child: const Text(
            "Play",
            style: TextStyle(fontSize: 30),
          ),
        ),
        const SizedBox(
          height: 25,
        )
      ],
    );
  }
}
