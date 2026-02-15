import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/helper_utils.dart';
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
      // await FirebaseAuth.instance.signInWithEmailAndPassword(
          // email: emailController.text.trim(),
          // password: passController.text.trim());

      /// create static user
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: "test@gmail.com",
            password: "123456",
          );


          Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found'){
        HelperUtils.showMessage(context, "No user found for that email." , Colors.cyan);
      }else if(e.code == 'wrong-password'){
        HelperUtils.showMessage(context, "invalid-credential" , Colors.red);
      }else if(e.code == 'invalid-credential'){
        HelperUtils.showMessage(context , "Error: ${e.message}" , Colors.green);
      }else{
        HelperUtils.showMessage(context ,"Something went wrong." , Colors.cyanAccent);
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
