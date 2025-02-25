import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';
import 'package:pfe_coashing_app/global/global_controller.dart';
import 'package:pfe_coashing_app/services/storage_service.dart';
import 'package:pfe_coashing_app/splash_screen/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize StorageService
  await StorageService.init();
  // Initialize token from storage if available
  final storedToken = await StorageService.getToken();
  if (storedToken != null) {
    GlobalController.token = storedToken;
  }
  runApp(const PfeCoashingApp());
}

class PfeCoashingApp extends StatelessWidget {
  const PfeCoashingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PFE Coaching App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.lightBackground,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.darkBackground,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.white),
        ),
      ),
      themeMode: ThemeMode.system,
      home: const SplashView(), // Show splash screen first
    );
  }
}

