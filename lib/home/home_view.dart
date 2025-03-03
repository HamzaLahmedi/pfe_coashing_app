import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_coashing_app/auth/sign_in_view.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';
import 'package:pfe_coashing_app/services/auth_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

final _authService = AuthService();

class _HomeViewState extends State<HomeView> {
  void _logout() async {
    await _authService.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SignInView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final FirebaseAuthService auth = FirebaseAuthService();
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.brightness == Brightness.dark
            ? AppColors.darkBackground
            : AppColors.lightBackground,
        title: Text(
          'Home',
          style: GoogleFonts.montserrat(
            //  color: AppColors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.normal,
          ),
        ),
        //just trying to add a sign out button to check functionality works or not :))
        actions: [
          IconButton(
            onPressed: () {
              _logout();
            }
            /* () async {
              final navigator = Navigator.of(context);
              await auth.signOut();
              navigator.pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const SignInView()),
                (route) => false,
              );
            }*/
            ,
            icon: Icon(
              Icons.logout,
              color: colorScheme.brightness == Brightness.dark
                  ? AppColors.lightBackground
                  : AppColors.darkBackground,
              size: 22,
            ),
          )
        ],
      ),
      body: Center(
        child: Text(
          'This is Home View',
          style: GoogleFonts.montserrat(
            //   color: AppColors.textPrimary,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
