import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:intl/intl.dart';
import 'package:mathlingo/controller/authentication_controller.dart';
import 'package:mathlingo/widgets/responsive_container.dart';
import '../../controller/user_controller.dart';
import 'package:mathlingo/domain/models/user.dart';

class SingupPage extends StatefulWidget {
  const SingupPage({super.key});

  @override
  State<SingupPage> createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
  final _formKey = GlobalKey<FormState>();
  final controllerEmail = TextEditingController(text: '');
  final controllerSchool = TextEditingController(text: '');
  final controllerGrade = TextEditingController(text: '');
  final dateController = TextEditingController();
  final controllerPassword = TextEditingController(text: '');

  AuthenticationController authenticationController = Get.find();

  _singup(email, school, grade, date, password, userController) async {
    logInfo('_singup $email $password');

    try {
      await userController.addUser(User(
        email: email,
        school: school,
        grade: grade,
        dateString: date,
      ));
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

  DateTime? selectedDate; // Make selectedDate nullable

  // Function to show the date picker dialog
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();
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
                controller: controllerGrade,
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

              // In your widget's build method
              TextFormField(
                readOnly: true,
                controller: TextEditingController(
                  text: selectedDate != null
                      ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                      : '', // Display selected date if available
                ),
                onTap: () {
                  _selectDate(context);
                },
                decoration: const InputDecoration(
                  labelText: 'Date',
                  hintText: 'Select a date',
                ),
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
                        controllerEmail.text,
                        controllerSchool.text,
                        int.parse(controllerGrade.text),
                        DateFormat('yyyy-MM-dd')
                            .format(selectedDate!)
                            .toString(),
                        controllerPassword.text,
                        userController);
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
