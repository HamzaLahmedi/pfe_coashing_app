import 'package:flutter/material.dart';
import 'package:pfe_coashing_app/auth/signup_view.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';
import 'package:pfe_coashing_app/core/utils/style.dart';
import 'package:pfe_coashing_app/core/utils/validator.dart';
import 'package:pfe_coashing_app/core/widgets/custom_elevated_button.dart';
import 'package:pfe_coashing_app/core/widgets/custom_progress_indicator.dart';
import 'package:pfe_coashing_app/core/widgets/custom_text_field.dart';
import 'package:pfe_coashing_app/global/global_controller.dart';
import 'package:pfe_coashing_app/home/navigation.dart';
import 'package:pfe_coashing_app/services/auth_service.dart';
import 'package:pfe_coashing_app/services/storage_service.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
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

    return _isLoading
        ? Center(
            child: CustomProgressIndicator(),
          )
        : Scaffold(
            // backgroundColor: AppColors.lightBackground,
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 100),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Center(
                      child: Image.asset(
                        'assets/images/dumbell_logo.png',
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Welcome to FitConnect",
                      style: TextStyles.mainBoldStyle(context),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Log in to continue your fitness journey",
                      style: TextStyles.regular12Style,
                    ),
                    SizedBox(
                      height: height * 0.07,
                    ),
                    CustomTextField(
                      hintText: "Enter your email",
                      icon: Icon(
                        Icons.email,
                        color: AppColors.purpleColor,
                      ),
                      controller: _emailController,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      labelText: "Email",
                      validator: ValidationUtils.validateEmail,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    CustomTextField(
                      hintText: "Enter your password",
                      icon:  Icon(
                        Icons.lock,
                        color: AppColors.purpleColor,
                      ),
                      controller: _passwordController,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      labelText: "Password",
                      validator: ValidationUtils.validatePassword,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    CustomElevatedButton(
                      text: "Sign In",
                      onPressed: () {
                        StorageService.removeToken();
                        GlobalController.token = null;
                        _login();
                      },
                      color: AppColors.purpleColor,
                      textColor: Colors.white,
                    ),
                    SizedBox(height: height * 0.05),
                    /*GestureDetector(
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
                ),*/
                    SizedBox(
                      height: height * 0.05,
                    ),
                    // Sign Up Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyles.mainBoldStyle(context).copyWith(
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
                            style: TextStyles.mainBoldStyle(context).copyWith(
                              fontSize: 16,
                              color: AppColors.purpleColor,
                              fontWeight: FontWeight.normal,
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
          );
  }
}
