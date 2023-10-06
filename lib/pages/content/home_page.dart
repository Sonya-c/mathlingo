import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:mathlingo/controller/authentication_controller.dart';
import 'package:mathlingo/controller/game_controller.dart';
import 'package:mathlingo/controller/game_session_controller.dart';
import '../../domain/models/game_session.dart';
import '../../widgets/responsive_container.dart';
import 'game_page.dart';

class HomePage extends StatefulWidget {
  final String email;

  const HomePage({super.key, required this.email});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthenticationController _authenticationController = Get.find();
  final GameController _gameController = Get.find();
  final GameSessionController _gameSessionController = Get.find();

  int level = 0;

  @override
  void initState() {
    super.initState();
    _getLevel();
  }

_getLevel() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  List<GameSession> gameSessions = [];

  if (connectivityResult == ConnectivityResult.none) {
    // Offline: Retrieve game sessions from local storage
    gameSessions = await _gameSessionController.getLocalGameSessionsByEmail(widget.email);
  } else {
    // Online: Retrieve game sessions from the web service
    gameSessions = await _gameSessionController.getGameSessions(widget.email);
  }

  if (gameSessions.isNotEmpty) {
    GameSession lastSession = gameSessions.last;
    logInfo(lastSession.level);
    await _gameController.retriveLevel(lastSession);
  }
}

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      appBar: AppBar(
        title: const Text('Mathlingo'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            key: const Key("home_page_retun_button"),
            onPressed: () async {
              await _gameController.clearState();
              await _authenticationController.logOut();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      backgroundColor: Colors.deepPurple[50],
      children: [
        const Text(
          "Welcome!",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        Text(
          (widget.email).isEmpty ? "Quest" : widget.email,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 25,
        ),
        Obx(
          () => Text(
            "Level ${_gameController.level}",
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        FilledButton(
          key: const Key("home_page_play_button"),
          onPressed: () async {
            Get.to(() => const GamePage());
          },
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Colors.orange[700],
            ),
            padding: const MaterialStatePropertyAll(
              EdgeInsets.fromLTRB(30, 15, 30, 15),
            ),
          ),
          child: const Text(
            "Play",
            style: TextStyle(fontSize: 20),
          ),
        ),
        const SizedBox(
          height: 25,
        )
      ],
    );
  }
}
