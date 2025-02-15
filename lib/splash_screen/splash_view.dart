import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_coashing_app/auth/signin_view.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
   @override
  void initState() {
    super.initState();
    // Delay for 2 seconds, then navigate to Sign In
    Future.delayed(const Duration(seconds: 2), () {
  if (mounted) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignInView()),
    );
  }
});
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff111111), Color(0xff2A2A2A)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "FIT",
                style: GoogleFonts.montserrat(
                  color: AppColors.textPrimary,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset("assets/images/heart-rate.png"),
              Text(
                "CONNECT",
                style: GoogleFonts.montserrat(
                  color: AppColors.textPrimary,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
