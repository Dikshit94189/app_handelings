import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  // Future<void> login() async {
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: emailController.text.trim(),
  //       password: passController.text.trim(),
  //     );
  //
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (_) => HomeScreen()));
  //   } catch (e) {
  //     print("Login Error: $e");
  //   }
  // }


  Future<void> login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passController.text.trim());

      Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found'){

      }else if(e.code == 'wrong-password'){

      }else if(e.code == 'invalid-credential'){

      }else{

      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: emailController,
                decoration: InputDecoration(labelText: "Email")),
            TextField(controller: passController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(onPressed: login, child: Text("Login"))
          ],
        ),
      ),
    );
  }
}
