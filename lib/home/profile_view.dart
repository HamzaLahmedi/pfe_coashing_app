import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
    
      appBar: AppBar(
       backgroundColor:colorScheme.brightness == Brightness.dark ? AppColors.darkBackground : AppColors.lightBackground,
        title: Text(
          'Profile',
          style: GoogleFonts.montserrat(
         //   color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'This is Profile View',
          style: GoogleFonts.montserrat(
          
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
