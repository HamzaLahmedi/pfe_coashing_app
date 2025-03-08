import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';
import 'package:pfe_coashing_app/core/utils/style.dart';

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
            style: TextStyles.regular12Style.copyWith(
              color: colorScheme.brightness == Brightness.light
                  ? AppColors.blackColor
                  : AppColors.lightBackground,
            ),
          ),
          Text(
            fitDetailValue,
            style:  TextStyles.regular12Style.copyWith(
              color: colorScheme.brightness == Brightness.light
                  ? AppColors.blackColor
                  : AppColors.lightBackground,
            ),
          ),
        ],
      ),
    );
  }
}
