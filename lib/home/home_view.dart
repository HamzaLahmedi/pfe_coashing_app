import 'package:flutter/material.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';
import 'package:pfe_coashing_app/core/widgets/custom_elevated_button.dart';
import 'package:pfe_coashing_app/firebase/auth.dart';
import 'package:pfe_coashing_app/auth/signin_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuthService _auth = FirebaseAuthService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        //just trying to add a sign out button to check functionality works or not :))
        actions: [
          CustomElevatedButton(
            text: "Sign Out",
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushAndRemoveUntil(
                context,
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