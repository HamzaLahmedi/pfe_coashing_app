import 'package:flutter/material.dart';

class SocialIconsSignIn extends StatelessWidget {
  const SocialIconsSignIn({
    super.key,
    this.icon,
  });
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Center(
        child: icon ?? Icon(Icons.no_accounts),
      ),
    );
  }
}
