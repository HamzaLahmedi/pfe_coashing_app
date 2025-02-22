import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_coashing_app/auth/sign_in_view.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';
import 'package:pfe_coashing_app/firebase/auth.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuthService auth = FirebaseAuthService();
    return  Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        title: Text(
          'Home',
          style: GoogleFonts.montserrat(
          //  color: AppColors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.normal,
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
          //    color: AppColors.error,
              size: 22,
            ),
          )
        ],
        
      ) ,
      body: Center(
        child: Text(
          'This is Home View',
          style: GoogleFonts.montserrat(
         //   color: AppColors.textPrimary,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}