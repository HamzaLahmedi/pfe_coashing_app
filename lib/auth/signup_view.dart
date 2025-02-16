import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_coashing_app/auth/sign_in_view.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';
import 'package:pfe_coashing_app/core/utils/toast.dart';
import 'package:pfe_coashing_app/core/widgets/custom_elevated_button.dart';
import 'package:pfe_coashing_app/core/widgets/custom_text_field.dart';
import 'package:pfe_coashing_app/firebase/auth.dart';
import 'package:pfe_coashing_app/home/navigation.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
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
                    "Sign up to continue your fitness journey",
                    style: GoogleFonts.montserrat(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Divider(
                  thickness: 0.5,
                ),
                CustomTextField(
                  hintText: "Enter your name",
                  icon: Icons.person_2_outlined,
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  controller: _usernameController,
                ),
                SizedBox(
                  height: 25,
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
                  height: height * 0.1,
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: "Sign Up",
                    onPressed: _signUp,
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
                      "Already have an account?",
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
                            builder: (context) => const SignInView(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign In",
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
    );
  }

  void _signUp() async {
    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      showToast(message: "Please fill in all fields.");
      return;
    }

    if (!isValidEmail(email)) {
      showToast(message: "Please enter a valid email address.");
      return;
    }

    if (password.length < 6) {
      showToast(message: "Password must be at least 6 characters long.");
      return;
    }

    try {
      User? user = await _auth.signUpWithEmailAndPassword(email, password);

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'username': username,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
        });

        showToast(message: "User successfully created");
        if (!mounted) return; // Check if the widget is still mounted
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Navigation()),
          (route) => false,
        );
      } else {
        showToast(message: "Error creating user.");
      }
    } catch (e) {
      showToast(message: "Error: ${e.toString()}");
    }
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}