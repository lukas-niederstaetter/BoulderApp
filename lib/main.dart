import 'package:boulder_app/pages/dashboard.dart';
import 'package:boulder_app/login/reset_password.dart';
import 'package:boulder_app/login/signup.dart';
import 'package:boulder_app/service/login_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BoulderFriend',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});


  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final _emailPadding = const EdgeInsets.symmetric(horizontal: 15);
  final _pwdPadding = const EdgeInsets.only(
      left: 15.0, right: 15.0, top: 15, bottom: 0);
  final _btnPadding = const EdgeInsets.symmetric(vertical: 16.0);

  final _emailTextController = TextEditingController();
  final _pwdTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _handleLogin(BuildContext context) async {
    try {
      String email = _emailTextController.text.trim();
      String password = _pwdTextController.text.trim();

      LoginService loginService = LoginService();
      User? user = await loginService.login(email, password);
      if(user != null){

      }
    } on FirebaseAuthException catch (exception) {
      if (kDebugMode) {
        print(exception.message);
      }
    }
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _pwdTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: _emailPadding,
                child: TextFormField(
                  controller: _emailTextController,
                  decoration: const InputDecoration(
                      labelText: 'Email'
                  ),
                  validator: (String? value) {
                    if(value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)){
                      return "Please enter a valid Email Address!";
                    }else{
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: _pwdPadding,
                child: TextFormField(
                  obscureText: true,
                  controller: _pwdTextController,
                  decoration: const InputDecoration(
                      labelText: 'Password'
                  ),
                  validator: (String? value) {
                    if(value!.isEmpty){
                      return "Please enter your Password!";
                    }else{
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: _btnPadding,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _handleLogin(context);
                    }
                  },
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
