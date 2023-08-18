import 'package:boulder_app/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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

  final _email = TextEditingController();
  final _pwd = TextEditingController();
  bool _emailValidate = false;
  bool _pwdValidate = false;

  @override
  void dispose() {
    _email.dispose();
    _pwd.dispose();
    super.dispose();
  }

  void checkTextState(){
    if(_email.text.isEmpty){
      setState(() {
        _emailValidate = false;
      });
    }
    else {
      setState(() {
        _emailValidate = true;
      });
    }
    if(_pwd.text.isEmpty){
      setState(() {
        _pwdValidate = false;
      });
    }
    else {
      setState(() {
        _pwdValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: _emailPadding,
              child: TextField(
                controller: _email,
                decoration: InputDecoration(
                  labelText: 'Email',
                  errorText: !(_emailValidate) ? 'Email cannot be empty' : null,
                ),
              ),
            ),
            Padding(
              padding: _pwdPadding,
              child: TextField(
                obscureText: true,
                controller: _pwd,
                decoration: InputDecoration(
                  labelText: 'Password',
                  errorText: !(_pwdValidate) ? 'Password cannot be empty' : null,
                ),
              ),
            ),
            TextButton(
              onPressed: (){
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: const Text(
                'Forgot Password',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: FloatingActionButton.small(
                heroTag: 'login-btn',
                onPressed: () {
                  checkTextState();
                  if(_emailValidate && _pwdValidate){
                    Navigator.push(
                      context, MaterialPageRoute(builder: (_) => const Dashboard()));
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
