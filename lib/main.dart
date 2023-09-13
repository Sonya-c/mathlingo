import 'package:mathlingo/domain/use_case/user_usecase.dart';
import 'package:mathlingo/controller/authentication_controller.dart';
import 'package:mathlingo/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathlingo/pages/HomePage.dart';

import 'domain/repositories/repository.dart';
import 'domain/use_case/authentication_usecase.dart';

void main() {
  Get.put(Repository());
  Get.put(AuthenticationUseCase());
  Get.put(UserUseCase());
  Get.put(AuthenticationController());
  Get.put(UserController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Mathlingo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Mathlingo'),
          ),
          body: const HomePage(),
        ));
  }
}
