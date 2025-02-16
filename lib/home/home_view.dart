import 'package:flutter/material.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';
import 'package:pfe_coashing_app/core/widgets/custom_elevated_button.dart';
import 'package:pfe_coashing_app/firebase/auth.dart';
import 'package:pfe_coashing_app/auth/sign_in_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuthService auth = FirebaseAuthService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        //just trying to add a sign out button to check functionality works or not :))
        actions: [
          CustomElevatedButton(
            text: "Sign Out",
            onPressed: () async {
              final navigator = Navigator.of(context);
              await auth.signOut();
              navigator.pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => SignInView()),
                (route) => false,
              );
            },
            color: AppColors.error,
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome to PFE Coashing App'),
      ),
    );
  }
}