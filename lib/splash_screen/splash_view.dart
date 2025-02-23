import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_coashing_app/auth/sign_in_view.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';
import 'package:pfe_coashing_app/home/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
 void initState() {
    super.initState();
    // Delay for 2 seconds, then navigate to the appropriate screen
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Navigation()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SignInView()),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        //backgroundColor: AppColors.lightBackground,
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "FIT",
                style: GoogleFonts.montserrat(
                 color: AppColors.primaryColor,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.fitness_center, color: AppColors.primaryColor, size: 70.0),
              //Image.asset("assets/images/icon_sign.png"),
              Text(
                "CONNECT",
                style: GoogleFonts.montserrat(
                  color: AppColors.primaryColor,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    
  }
}
