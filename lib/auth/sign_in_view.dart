import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_coashing_app/auth/signup_view.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';
import 'package:pfe_coashing_app/core/utils/toast.dart';
import 'package:pfe_coashing_app/core/widgets/custom_elevated_button.dart';
import 'package:pfe_coashing_app/core/widgets/custom_text_field.dart';
import 'package:pfe_coashing_app/firebase/auth.dart';
import 'package:pfe_coashing_app/home/navigation.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: AppColors.lightBackground,
        body: Column(children: [
          Center(
            child: Image.asset(
              "assets/images/icon_sign.png",
            ),
          ),
        ]));
  }

/*
SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: height * 0.05,
                ),
                Center(
                  child: Text(
                    "FIT CONNECT",
                    style: GoogleFonts.montserrat(
                      color: AppColors.textPrimary,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "Log in to continue your fitness journey",
                    style: GoogleFonts.montserrat(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                Divider(
                  thickness: 0.5,
                ),
                CustomTextField(
                  hintText: "Enter your email",
                  icon: Icons.email_outlined,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                ),
                SizedBox(
                  height: 25,
                ),
                CustomTextField(
                  hintText: "Enter your password",
                  icon: Icons.lock_outline,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordController,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Forget your password?",
                  style: GoogleFonts.montserrat(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: "Sign In",
                    onPressed: _signIn,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: " G Google ",
                    textColor: AppColors.primary,
                    color: AppColors.white,
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: GoogleFonts.montserrat(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupView(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.montserrat(
                          color: AppColors.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 0.1,
                ),
              ],
            ),
          ),
        ),
      ),
*/
  void _signIn() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Check if all fields are filled
    if (email.isEmpty || password.isEmpty) {
      showToast(message: "Please fill in all fields.");
      return;
    }

    // Check if the email is valid
    if (!isValidEmail(email)) {
      showToast(message: "Please enter a valid email address.");
      return;
    }

    // Call the signInWithEmailAndPassword method
    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      // Create or update the user document in Firestore
      await _firestore.collection('users').doc(user.uid).set({
        'email': user.email,
        'lastSignInTime': user.metadata.lastSignInTime,
      }, SetOptions(merge: true));

      showToast(message: "User successfully signed in");

      if (!mounted) return; // Check if the widget is still mounted

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Navigation()),
        (route) => false,
      );
    } else {
      showToast(
        message: "An error occurred while signing in the user.",
      );
    }
  }

  bool isValidEmail(String email) {
    // Use a regular expression to validate the email address
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
