import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:mathlingo/controller/game_controller.dart';
import 'package:mathlingo/domain/repositories/game_repository.dart';
import 'package:mathlingo/domain/use_case/game_usecase.dart';
import 'package:mathlingo/domain/use_case/user_usecase.dart';
import 'package:mathlingo/controller/authentication_controller.dart';
import 'package:mathlingo/controller/user_controller.dart';
import 'package:mathlingo/pages/auth/login_page.dart';
import 'package:mathlingo/pages/content/home_page.dart';
import 'domain/repositories/repository.dart';
import 'domain/use_case/authentication_usecase.dart';
import 'package:mathlingo/domain/models/user.dart';

void main() {
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );

  Get.put(Repository());
  Get.put(AuthenticationUseCase());
  Get.put(UserUseCase());
  Get.put(AuthenticationController());
  Get.put(UserController());
  Get.put(GameRepository());
  Get.put(GameUseCase());
  Get.put(GameController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationController authenticationController = Get.find();

    return GetMaterialApp(
      title: 'Mathlingo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Obx(() => authenticationController.isLogged
           ? const HomePage()
           : const LoginPage())
    );
  }
}
