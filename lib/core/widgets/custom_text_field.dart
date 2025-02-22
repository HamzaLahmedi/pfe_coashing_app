import 'package:flutter/material.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key, required this.hintText, required this.icon, required this.obscureText, this.keyboardType, this.controller,
  });
final String hintText ;
final IconData icon ;
final TextInputType? keyboardType;
final bool obscureText ;
final TextEditingController? controller;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
   bool _isObscured=true;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller:widget.controller ,
      keyboardType: widget.keyboardType,
          obscureText: widget.obscureText? _isObscured : false, // Hide text
          style: TextStyle(color: Colors.white), // Text color
          decoration: InputDecoration(
            prefixIcon: Icon(widget.icon, color: Colors.white,), // Light blue icon
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.white),
            suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              )
            : null,
             // Greyish blue text
            border: UnderlineInputBorder(
            //  borderSide: BorderSide(color: AppColors.primary), // Bottom border only
            ),
            enabledBorder: UnderlineInputBorder(
           //   borderSide: BorderSide(color: AppColors.primary, width: 2), // Default bottom border
            ),
            focusedBorder: UnderlineInputBorder(
            //  borderSide: BorderSide(color: AppColors.textPrimary, width: 2), // Highlighted bottom border
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 15),
          ),
          
        );
  }
}
