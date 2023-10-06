import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loggy/loggy.dart';
import 'package:mathlingo/controller/game_controller.dart';
import 'package:mathlingo/controller/game_session_controller.dart';
import 'package:mathlingo/domain/models/game_session.dart';
import 'package:mathlingo/domain/repositories/game_session_repository.dart';
import 'package:mathlingo/domain/use_case/game_session_usecase.dart';
import 'package:mathlingo/domain/use_case/game_usecase.dart';
import 'package:mathlingo/domain/use_case/user_usecase.dart';
import 'package:mathlingo/controller/authentication_controller.dart';
import 'package:mathlingo/controller/user_controller.dart';
import 'package:mathlingo/pages/auth/login_page.dart';
import 'package:mathlingo/pages/content/home_page.dart';
import 'domain/repositories/repository.dart';
import 'domain/use_case/authentication_usecase.dart';

void main() async {
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  // Authentication
  Get.put(Repository());
  Get.put(AuthenticationUseCase());
  Get.put(AuthenticationController());
  // User controller
  Get.put(UserUseCase());
  Get.put(UserController());
  // Game controller
  Get.put(GameUseCase());
  Get.put(GameController());
  // Game session
  Get.put(GameSessionRepository());
  Get.put(GameSessionUseCase());
  Get.put(GameSessionController());

  await Hive.initFlutter();
  Hive.registerAdapter(GameSessionAdapter());

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
      home: Obx(
        () => authenticationController.isLogged
            ? HomePage(email: authenticationController.email)
            : const LoginPage(),
      ),
    );
  }
}
