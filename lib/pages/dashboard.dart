import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, required String title});

  @override
  State<Dashboard> createState() => _DashboardPage();
}

class _DashboardPage extends State<Dashboard>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hey"),
      ),
    );
  }
}
