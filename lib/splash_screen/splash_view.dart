import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_coashing_app/auth/sign_in_view.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';
import 'package:pfe_coashing_app/home/navigation.dart';
import 'package:pfe_coashing_app/services/auth_service.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(seconds: 1)); // Add delay for splash effect

    final response = await _authService.getProfile();
    /*debugPrint("*************************************************************************************************************************************");
    debugPrint(response.data.toString());
    debugPrint("*****************");*/
    if (!mounted) return; // Check if the widget is still mounted

    if (response.isError) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignInView()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Navigation()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print(
        '****************************************************************************************************');
    print(MediaQuery.of(context).size.height);
    print(
        '****************************************************************************************************');

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "FIT",
                  style:GoogleFonts.poppins(
                    color: AppColors.purpleColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //Icon(Icons.fitness_center, color: AppColors.purpleColor, size: 70.0),
                Image.asset("assets/images/dumbell_logo.png"),
                Text(
                  "CONNECT",
                  style: GoogleFonts.poppins(
                    color: AppColors.purpleColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
