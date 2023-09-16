import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:mathlingo/controller/authentication_controller.dart';
import 'package:mathlingo/pages/auth/singup_page.dart';

import '../../widgets/center_container.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final controllerEmail = TextEditingController(text: '');
  final controllerPassword = TextEditingController(text: '');

  AuthenticationController authenticationController = Get.find();

  _login(email, password) async {
    logInfo('_login $email $password');

    try {
      await authenticationController.login(email, password);
      Get.snackbar(
        "Login sucessfull",
        "Welcome!",
        icon: const Icon(Icons.person, color: Colors.green),
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (error) {
      Get.snackbar(
        "Login Failed",
        error.toString(),
        icon: const Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(children: [
      const Center(
        child: Text(
          'Mathlingo',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login',
                style: TextStyle(
                  fontSize: 30,
                )),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: controllerEmail,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "Enter email";
                } else if (!value.contains('@')) {
                  return "Enter valid email address";
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: controllerPassword,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "Enter password";
                } else if (value.length < 6) {
                  return "Password should have at least 6 characters";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              key: const Key('login_button'),
              onPressed: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                final form = _formKey.currentState;
                form!.save();
                if (_formKey.currentState!.validate()) {
                  await _login(controllerEmail.text, controllerPassword.text);
                }
              },
              child: const Text('Login'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              key: const Key('create_account_button'),
              onPressed: () {
                Get.to(() => const SingupPage());
              },
              child: const Text('Create Account'),
            ),
          ],
        ),
      )
    ]);
  }
}
