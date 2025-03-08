import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_coashing_app/auth/sign_in_view.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';
import 'package:pfe_coashing_app/core/utils/style.dart';
import 'package:pfe_coashing_app/core/utils/validator.dart';
import 'package:pfe_coashing_app/core/widgets/custom_elevated_button.dart';
import 'package:pfe_coashing_app/core/widgets/custom_progress_indicator.dart';
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

    return _isLoading
        ? Center(
            child: CustomProgressIndicator(),
          )
        : Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Image.asset(
                              "assets/images/dumbell_logo.png",
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
                            style: TextStyles.mainBoldStyle(context),
                          ),
                          Text(
                            "Join the fitness community today",
                            style: TextStyles.regular12Style,
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
                                  icon: Image.asset(
                                      "assets/images/height_icon.png"),
                                  obscureText: false,
                                  keyboardType: TextInputType.number,
                                  controller: _heightController,
                                  validator: ValidationUtils.validateHeight,
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: CustomTextField(
                                  labelText: "Weight",
                                  hintText: "Weight in kg",
                                  icon: Image.asset(
                                      "assets/images/weight_icon.png"),
                                  obscureText: false,
                                  keyboardType: TextInputType.number,
                                  controller: _weightController,
                                  validator: ValidationUtils.validateWeight,
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
                            icon: Icon(
                              Icons.person_2_outlined,
                              color: AppColors.purpleColor,
                            ),
                            obscureText: false,
                            keyboardType: TextInputType.name,
                            controller: _usernameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Full Name is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          CustomTextField(
                            labelText: "Email",
                            hintText: "Enter your email",
                            icon: Icon(
                              Icons.email_outlined,
                              color: AppColors.purpleColor,
                            ),
                            obscureText: false,
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            validator: ValidationUtils.validateEmail,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          CustomTextField(
                            labelText: "Password",
                            hintText: "Enter your password",
                            icon: Icon(
                              Icons.lock_outline,
                              color: AppColors.purpleColor,
                            ),
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            controller: _passwordController,
                            validator: ValidationUtils.validatePassword,
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          CustomElevatedButton(
                            text: "Sign Up",
                            onPressed: () {
                              _register();
                            },
                            color: AppColors.purpleColor,
                            textColor: Colors.white,
                          ),
                          SizedBox(height: height * 0.04),
                          Text(
                            "By signing up, you agree to our",
                            style: TextStyles.regular12Style,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Terms ",
                                style: TextStyles.regular12Style.copyWith(
                                  color: AppColors.purpleColor,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "&",
                                style: TextStyles.regular12Style,
                              ),
                              Text(
                                " Privacy Policy",
                                style: TextStyles.regular12Style.copyWith(
                                  color: AppColors.purpleColor,
                                  fontSize: 14,
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
                                style: TextStyles.regular12Style.copyWith(
                                  fontSize: 16,
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
                                  style: TextStyles.regular12Style.copyWith(
                                    color: AppColors.purpleColor,
                                    fontSize: 14,
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
          );
  }
}
