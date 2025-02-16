import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';
import 'package:pfe_coashing_app/firebase/auth.dart';
import 'package:pfe_coashing_app/auth/sign_in_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuthService auth = FirebaseAuthService();

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        title: Text(
          'Home',
          style: GoogleFonts.montserrat(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        //just trying to add a sign out button to check functionality works or not :))
        actions: [
          IconButton(
            onPressed: () async {
              final navigator = Navigator.of(context);
              await auth.signOut();
              navigator.pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const SignInView()),
                (route) => false,
              );
            },
            icon: Icon(
              Icons.logout,
              color: AppColors.error,
            ),
          )
        ],
      ),
      body: Center(
        child: Text('Welcome to PFE Coashing App'),
      ),
    );
  }
}
