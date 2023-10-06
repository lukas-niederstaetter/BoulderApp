import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key, required title});

  @override
  State<SignUp> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUp>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
    );
  }

}