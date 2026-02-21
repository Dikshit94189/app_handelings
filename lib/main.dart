import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_tasks/firebase_options.dart';
import 'package:new_tasks/screens/dashboard/dashborad_screen.dart';
import 'package:new_tasks/screens/home_screen.dart';
import 'package:new_tasks/screens/login_screen.dart';
import 'package:new_tasks/services/hive_services.dart';
import 'package:new_tasks/view_model/quote_view.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await HiveServices.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
Widget? _defaultScreen;

  @override
  void initState() {
    super.initState();
    checkFirstTime();
  }

 Future<void> checkFirstTime() async{
      bool isFirstTime = HiveServices.isFirstTime();
      User? user  =   FirebaseAuth.instance.currentUser;
      if(isFirstTime){
        await HiveServices.setFirstTime(false);
        _defaultScreen = DashboardScreen();
      }else if(user != null){
        _defaultScreen =  HomeScreen();
      }else{
        _defaultScreen = LoginScreen();
      }

      setState(() {});
 }


  @override
  Widget build(BuildContext context) {
    if(_defaultScreen==null){
      return MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuoteViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: _defaultScreen
      ),
    );
  }
}

