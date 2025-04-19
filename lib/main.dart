
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_coashing_app/auth/sign_in_view.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';
import 'package:pfe_coashing_app/global/global_controller.dart';
import 'package:pfe_coashing_app/services/storage_service.dart';
import 'package:pfe_coashing_app/splash_screen/splash_view.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  

  // Initialize StorageService
  await StorageService.init();
  // Initialize token from storage if available
  final storedToken = await StorageService.getToken();
  if (storedToken != null) {
    GlobalController.token = storedToken;
  }
  await dotenv.load(fileName: ".env");
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
        primaryColor: AppColors.purpleColor,
        scaffoldBackgroundColor: AppColors.lightBackground,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.purpleColor,
        scaffoldBackgroundColor: AppColors.darkBackground,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.white),
        ),
      ),
      themeMode: ThemeMode.system,
      home: const SplashView(), // Show splash screen first
    );
  }
}

