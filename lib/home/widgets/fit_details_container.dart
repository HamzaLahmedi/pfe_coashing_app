import 'package:flutter/material.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';
import 'package:pfe_coashing_app/home/widgets/fit_details.dart';

class FitDetailsContainer extends StatelessWidget {
  const FitDetailsContainer({
    super.key,
    required this.heigthScreen,
    required this.colorScheme,
  });

  final double heigthScreen;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heigthScreen * 0.1,
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.brightness == Brightness.dark
            ? AppColors.primaryColor
            : AppColors.darkBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        spacing: 10,
        children: [
          FitDetails(colorScheme: colorScheme,fitDetail: "Calories",fitDetailValue: "200",),
          FitDetails(colorScheme: colorScheme,fitDetail: "Height",fitDetailValue: "177cm",),
          FitDetails(colorScheme: colorScheme,fitDetail: "Weight",fitDetailValue: "75kg",),
        ],
      ),
    );
  }
}