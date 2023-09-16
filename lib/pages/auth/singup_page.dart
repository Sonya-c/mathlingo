import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:mathlingo/controller/authentication_controller.dart';
import 'package:mathlingo/widgets/responsive_container.dart';

class SingupPage extends StatefulWidget {
  const SingupPage({super.key});

  @override
  State<SingupPage> createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
  final _formKey = GlobalKey<FormState>();
  final controllerEmail = TextEditingController(text: '');
  final controllerSchool = TextEditingController(text: '');
  final controllerPassword = TextEditingController(text: '');

  AuthenticationController authenticationController = Get.find();

  _singup(email, password) async {
    logInfo('_singup $email $password');

    try {
      await authenticationController.signUp(email, password);
      logInfo("_singup [sucess]");
      Get.snackbar(
        "Sign Up sucessfull",
        '',
        icon: const Icon(Icons.person, color: Colors.green),
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (error) {
      logError("_sinup [failed]: $error");

      Get.snackbar(
        "Sing up failed",
        error.toString(),
        icon: const Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      children: [
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
              const Text('Create account',
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
                controller: controllerSchool,
                decoration: const InputDecoration(
                  labelText: 'School',
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Enter Scholl";
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Grade',
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Enter Grade";
                  }
                  return null;
                },
              ),
              InputDatePickerFormField(
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
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
                key: const Key('create_accunt_button'),
                onPressed: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  final form = _formKey.currentState;
                  form!.save();
                  if (_formKey.currentState!.validate()) {
                    await _singup(
                        controllerEmail.text, controllerPassword.text);
                  }
                },
                child: const Text('Create account'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                key: const Key('login_button'),
                onPressed: () {
                  Get.back();
                },
                child: const Text('Have an account? Login'),
              ),
            ],
          ),
        )
      ],
    );
  }
}
