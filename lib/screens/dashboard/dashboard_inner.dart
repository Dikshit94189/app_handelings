import 'package:flutter/material.dart';

import '../login_screen.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Screen 1")),
      body: Center(child: Text("This is Screen 1")),
    );
  }
}

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Screen 2")),
      body: Center(child: Text("This is Screen 2")),
    );
  }
}

class Screen3 extends StatelessWidget {
  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Screen 3")),
      body: Center(child: Column(
        children: [
          Text('Dddddd'),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            },
            child: const Text("Continue to Login"),
          ),

        ],

      )),
    );
  }
}
