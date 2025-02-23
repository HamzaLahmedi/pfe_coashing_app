import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';

class LiveView extends StatelessWidget {
  const LiveView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
     
      appBar: AppBar(
       backgroundColor:colorScheme.brightness == Brightness.dark ? AppColors.darkBackground : AppColors.lightBackground,
        title: Text(
          'Live Sessions',
          style: GoogleFonts.montserrat(
       
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'This is Live Sessions',
          style: GoogleFonts.montserrat(
        
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
