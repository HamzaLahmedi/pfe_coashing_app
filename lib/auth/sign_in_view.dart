import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_coashing_app/auth/signup_view.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';
import 'package:pfe_coashing_app/core/widgets/custom_elevated_button.dart';
import 'package:pfe_coashing_app/core/widgets/custom_text_field.dart';
import 'package:pfe_coashing_app/home/navigation.dart';
import 'package:pfe_coashing_app/services/auth_service.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() => _isLoading = true);
    
    try {
      final result = await _authService.login(
        _emailController.text,
        _passwordController.text,
      );

      if (!result.isError) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Navigation(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result.errorMessage ?? 'Login failed')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Scaffold(
        // backgroundColor: AppColors.lightBackground,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              child: Column(children: [
                SizedBox(
                  height: height * 0.04,
                ),
                Center(
                  child: Icon(Icons.fitness_center, color: AppColors.primaryColor, size: 100.0),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Welcome to FitConnect",
                  style: GoogleFonts.montserrat(
                    //color: AppColors.darkBackground,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Log in to continue your fitness journey",
                  style: GoogleFonts.montserrat(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: height * 0.07,
                ),
                CustomTextField(
                  hintText: "Enter your email",
                  icon: Icons.email_outlined,
                  controller: _emailController,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  labelText: "Email",
                ),
                SizedBox(
                  height: 18,
                ),
                CustomTextField(
                  hintText: "Enter your password",
                  icon: Icons.lock_outline,
                  controller: _passwordController,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  labelText: "Password",
                ),
                SizedBox(
                  height: 18,
                ),
                CustomElevatedButton(
                  text: "Sign In",
                  onPressed: () {
                    _login();
                  },
                  color: AppColors.buttonPrimary,
                  textColor: Colors.white,
                ),
                SizedBox(height: height * 0.05),
                GestureDetector(
                  onTap: () {
                    // Handle forgot password
                  },
                  child: Text(
                    "Forgot Password?",
                    style: GoogleFonts.montserrat(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                // Sign Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: GoogleFonts.montserrat(
                        // color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
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
                          color: AppColors.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ),
        
      ),
      if (_isLoading)
          Container(
            color: Colors.black26,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
    
  }
}

