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

  _validateConfirmPassword(){
    var password = _pwdTextController.text.trim();
    var inputPwd = _pwdCheckTextController.text.trim();

    if(password.isEmpty){
      return "Please confirm your Password";
    }
    else if(password.compareTo(inputPwd) != 0){
      return "Password not confirmed";
    }
    else {
      return null;
    }
  }
  
  _validatePassword(){
    var password = _pwdTextController.text.trim();
    RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (password.isEmpty) {
      return 'Please enter your Password';
    } else {
      if (!regex.hasMatch(password)) {
        return 'Please enter a valid Password';
      } else {
        return null;
      }
    }
  }

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
              ),
              Padding(
                padding: _emailPadding,
                child: TextFormField(
                  controller: _emailTextController,
                  decoration: const InputDecoration(
                      labelText: 'Email'
                  ),
                  validator: (String? value) {
                    if(value!.isEmpty) {
                      return "Please enter your Email";
                    }
                    else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: _pwdPadding,
                child: TextFormField(
                  controller: _pwdTextController,
                  decoration: const InputDecoration(
                      labelText: 'Password'
                  ),
                  validator: (String? value) {
                    return _validatePassword();
                  },
                ),
              ),
              Padding(
                padding: _namesPadding,
                child: TextFormField(
                  controller: _surnameTextController,
                  decoration: const InputDecoration(
                      labelText: 'Confirm Password'
                  ),
                  validator: (String? value) {
                      return _validateConfirmPassword();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}