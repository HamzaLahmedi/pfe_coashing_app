import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pfe_coashing_app/splash_screen/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    print("Firebase initialized: ${Firebase.app().options}");
  } catch (e) {
    print("Error initializing Firebase : $e");
  }
  runApp(PfeCoashingApp());
}

class PfeCoashingApp extends StatelessWidget {
  const PfeCoashingApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
    );
  }
}

