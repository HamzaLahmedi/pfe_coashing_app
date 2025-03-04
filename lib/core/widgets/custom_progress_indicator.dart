import 'package:flutter/material.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        //valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }
}