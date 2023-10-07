import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key, required title});

  @override
  State<SignUp> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUp>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _namesPadding = const EdgeInsets.symmetric(horizontal: 15);
  final _emailPadding = const EdgeInsets.symmetric(horizontal: 15);
  final _pwdPadding = const EdgeInsets.only(
      left: 15.0, right: 15.0, top: 15, bottom: 0);
  final _btnPadding = const EdgeInsets.symmetric(vertical: 16.0);

  final _nameTextController = TextEditingController();
  final _surnameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _pwdTextController = TextEditingController();
  final _pwdCheckTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: _namesPadding,
                child: TextFormField(
                  controller: _nameTextController,
                  decoration: const InputDecoration(
                    labelText: 'First Name'
                  ),
                  validator: (String? value) {
                    if(value!.isEmpty) {
                      return "Please enter your First Name";
                    }
                    else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: _namesPadding,
                child: TextFormField(
                  controller: _surnameTextController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name'
                  ),
                  validator: (String? value) {
                    if(value!.isEmpty) {
                      return "Please enter your Last Name";
                    }
                    else {
                      return null;
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}