import 'package:flutter/material.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';
import 'package:pfe_coashing_app/core/utils/style.dart';

class ProfileListTile extends StatelessWidget {
  const ProfileListTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.contentPadding,
    required this.leading,
  });
  final String title;
  final String subtitle;
  final EdgeInsetsGeometry? contentPadding;
  final Widget leading;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: contentPadding ?? contentPadding,
      title: Text(
        title,
        style: TextStyles.mainNormalStyle,
      ),
      subtitle: Text(
        subtitle,
        style: TextStyles.secondaryNormalStyle,
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: AppColors.primaryColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      leading: leading,
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
