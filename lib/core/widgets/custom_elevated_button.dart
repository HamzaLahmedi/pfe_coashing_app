import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key, this.onPressed, required this.text,  this.color, this.textColor,
  });
final Function()? onPressed;
final String text;
final Color? color;
final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor:color ??  AppColors.primary , // Light blue color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
              elevation: 2, // Slight shadow for depth
            ),
            child: Text(
              text,
              style: GoogleFonts.montserrat(
                color: textColor ?? AppColors.white, // White text
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            
          );
  }
}
