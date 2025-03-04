import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_coashing_app/auth/sign_in_view.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';
import 'package:pfe_coashing_app/core/widgets/custom_elevated_button.dart';
import 'package:pfe_coashing_app/core/widgets/custom_text_field.dart';
import 'package:pfe_coashing_app/home/navigation.dart';
import 'package:pfe_coashing_app/services/auth_service.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {

final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;
  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final result = await _authService.register(
        _usernameController.text, 
        _emailController.text,    
        _passwordController.text,
        double.parse(_heightController.text),
        double.parse(_weightController.text),
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
          SnackBar(content: Text(result.errorMessage ?? 'Registration failed')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();

    _heightController.dispose();
    _weightController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Stack(
      children:[
        Scaffold(
       
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Form(
               key:_formKey , 
                child: Column(
                  children: [
                    Center(
                      child: Icon(
                        Icons.fitness_center,
                        color: AppColors.primaryColor,
                        size: 70.0,
                      ),
                      /* Image.asset(
                    "assets/images/icon_sign.png",
                  ),*/
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Create Account",
                      style: GoogleFonts.montserrat(
                        //color: AppColors.darkBackground,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    Text(
                      "Join the fitness community today",
                      style: GoogleFonts.montserrat(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            labelText: "Height",
                            hintText: "Height in cm",
                            icon: Icons.height,
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            controller: _heightController,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: CustomTextField(
                            labelText: "Weight",
                            hintText: "Weight in kg",
                            icon: Icons.fitness_center,
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            controller: _weightController,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      labelText: "Full Name",
                      hintText: "Enter your name",
                      icon: Icons.person_2_outlined,
                      obscureText: false,
                      keyboardType: TextInputType.name,
                      controller: _usernameController,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      labelText: "Email",
                      hintText: "Enter your email",
                      icon: Icons.email_outlined,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomTextField(
                      labelText: "Password",
                      hintText: "Enter your password",
                      icon: Icons.lock_outline,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordController,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    CustomElevatedButton(
                      text: "Sign Up",
                      onPressed: () {
                       _register();
                      },
                      color: AppColors.buttonPrimary,
                      textColor: Colors.white,
                    ),
                    SizedBox(height: height * 0.04),
                    Text(
                      "By signing up, you agree to our",
                      style: GoogleFonts.montserrat(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Terms ",
                          style: GoogleFonts.montserrat(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          "&",
                          style: GoogleFonts.montserrat(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          " Privacy Policy",
                          style: GoogleFonts.montserrat(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: GoogleFonts.montserrat(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
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
                              color: AppColors.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
      if (_isLoading)
          Container(
            color: Colors.purple,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ] 
    );
  }



  
}
