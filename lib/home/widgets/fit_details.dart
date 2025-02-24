import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';

class FitDetails extends StatelessWidget {
  const FitDetails({
    super.key,
    required this.colorScheme, required this.fitDetail, required this.fitDetailValue,
  });

  final ColorScheme colorScheme;
final String fitDetail;
final String fitDetailValue;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            fitDetail,
            style: GoogleFonts.montserrat(
              color: colorScheme.brightness == Brightness.light
                  ? AppColors.textSecondary
                  : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            fitDetailValue,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: colorScheme.brightness == Brightness.light
                  ? AppColors.buttonPrimary
                  : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
