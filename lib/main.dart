import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pfe_coashing_app/auth/sign_in_view.dart';
import 'package:pfe_coashing_app/splash_screen/splash_view.dart';
import 'package:pfe_coashing_app/home/navigation.dart';
import 'package:pfe_coashing_app/core/widgets/custom_progress_indicator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    debugPrint("Firebase initialized: ${Firebase.app().options}");
  } catch (e) {
    debugPrint("Error initializing Firebase: $e");
  }
  runApp(const PfeCoashingApp());
}

class PfeCoashingApp extends StatelessWidget {
  const PfeCoashingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PFE Coaching App',
      debugShowCheckedModeBanner: false,
      home: const SplashView(), // Show splash screen first
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CustomProgressIndicator(); // Show custom progress indicator while waiting for auth state
        } else if (snapshot.hasData) {
          return const Navigation(); // User is signed in, show home screen
        } else {
          return const SignInView(); // User is not signed in, show sign-in screen
        }
      },
    );
  }
}
