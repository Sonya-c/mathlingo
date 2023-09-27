import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathlingo/controller/authentication_controller.dart';
import 'package:mathlingo/controller/game_controller.dart';
import 'package:mathlingo/controller/game_session_controller.dart';
import '../../domain/models/game_session.dart';
import '../../widgets/responsive_container.dart';
import 'game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //§User user = Get.arguments[0];
  AuthenticationController authenticationController = Get.find();
  GameController gameController = Get.find();
  GameSessionController _gameSessionController = Get.find();

  int level = 0;

  @override
  void initState() {
    super.initState();
    _getLevel();
    _setLevel();
  }

  _getLevel() async {
    String email = await authenticationController.email;

    List gameSessions = await _gameSessionController.getGameSessions(email);

    if (gameSessions.isNotEmpty) {
      GameSession lastSession = gameSessions[gameSessions.length - 1];

      if (lastSession.correctAnwers > 3) {
        level = lastSession.level + 1;
      } else if (lastSession.correctAnwers < 3) {
        level = lastSession.level - 1;
      } else {
        level = lastSession.level;
      }

      await gameController.setLevel(level);
    }
  }

  _setLevel() async {
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
            Get.to(() => GamePage(updateHome: _setLevel));
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
