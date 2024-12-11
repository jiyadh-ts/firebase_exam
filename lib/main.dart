import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_exam/controller/homescreencontroller.dart';
import 'package:firebase_exam/firebase_options.dart';
import 'package:firebase_exam/view/HomeScreen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>Homescreencontroller())
      ],
      child: MaterialApp(
        home: Homescreen(),
      ),
    );
  }
}
