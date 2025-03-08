import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';

class TextStyles {
  //we can use this method to change the color of the text based on the theme of the app (dark or light) 
  //we used method so we can access the context of the widget 
  static TextStyle mainBoldStyle(BuildContext context) {
    return GoogleFonts.poppins(
      color: Theme.of(context).brightness == Brightness.dark ? AppColors.lightBackground : AppColors.blackColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }

  static final TextStyle regular12Style = GoogleFonts.poppins(
    color: AppColors.greyColor,
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle mainNormalStyle = GoogleFonts.poppins(
    // color: AppColors.textPrimary,
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );
}