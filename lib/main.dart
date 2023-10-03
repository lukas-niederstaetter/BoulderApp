import 'dart:async';

import 'package:boulder_app/login/reset_password.dart';
import 'package:boulder_app/login/signup.dart';
import 'package:boulder_app/pages/dashboard.dart';
import 'package:boulder_app/service/user_service.dart';
import 'package:boulder_app/themes/dark_theme_provider.dart';
import 'package:boulder_app/themes/dark_theme_styles.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp(title: 'Climbr',));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required String title});

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  late StreamSubscription<User?> user;

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
    await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget? child) {
          return MaterialApp(
            title: 'Climbr',
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            home: const LoginPage(title: 'Climbr'),
            routes: {
              "dashboard": (context) =>
                  const Dashboard(title: 'Climbr'),
              "signUp": (context) =>
                  const SignUp(title: 'Climbr: Sign Up'),
              "resetPassword": (context) =>
                  const ResetPassword(),
            },
          );
        },
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

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

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  Future<bool> _handleLogin(BuildContext context) async {
    try {
      String email = _emailTextController.text.trim();
      String password = _pwdTextController.text.trim();

      LoginService loginService = LoginService();
      User? user = await loginService.login(email, password);
      if(user != null){
        return true;
      }
      else {
        return false;
      }
    } on FirebaseAuthException catch (exception) {
      if (kDebugMode) {
        print(exception.message);
      }
      return false;
    }
  }

  @override
  void initState(){
    super.initState();
    getConnectivity();
  }

  getConnectivity() async {
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    if (!isDeviceConnected && isAlertSet == false) {
      showDialogBox();
      setState(() => isAlertSet = true);
    }

    subscription = Connectivity().onConnectivityChanged.listen(
          (ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
          setState(() => isAlertSet = true);
        }
      },
    );
  }

  showDialogBox() => showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('No Internet Connection!'),
      content: const Text(
          'Please check your Connection and make sure your connected to the Internet'),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () async {
            isDeviceConnected =
            await InternetConnectionChecker().hasConnection;
            if (isDeviceConnected) {
              if (!context.mounted) return;
              Navigator.pop(context, 'Cancel');
              setState(() => isAlertSet = false);
            }
          },
        ),
      ],
    ),
  );

  @override
  void dispose() {
    _emailTextController.dispose();
    _pwdTextController.dispose();
    subscription.cancel();
    dispose();
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
                Column(
                  children: [
                    Padding(
                      padding: _btnPadding,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            bool check = await _handleLogin(context);
                            if(check){
                              if (!context.mounted) return;
                              Navigator.pushNamed(context, "dashboard");
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white54,
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            )
                        ),
                        child: const Text('Login'),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                          Navigator.pushNamed(context, "signUp");
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
}
