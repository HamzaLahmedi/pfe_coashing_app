import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';

class TextStyles {
  static final TextStyle mainBoldStyle = GoogleFonts.montserrat(
    // color: AppColors.textPrimary,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle secondaryNormalStyle = GoogleFonts.montserrat(
    color: AppColors.textSecondary,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle mainNormalStyle = GoogleFonts.montserrat(
    // color: AppColors.textPrimary,
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );
}