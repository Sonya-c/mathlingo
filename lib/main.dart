import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathlingo/pages/HomePage.dart';

void main() {
  // Get.put(controller());

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
