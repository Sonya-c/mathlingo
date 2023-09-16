import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathlingo/controller/authentication_controller.dart';
import '../../widgets/responsive_container.dart';
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
        FilledButton(
          onPressed: () {
            Get.to(() => const GamePage());
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
        ),
        const Placeholder()
      ],
    );
  }
}
