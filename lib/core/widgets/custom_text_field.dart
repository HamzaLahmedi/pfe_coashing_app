import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_coashing_app/core/utils/color.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key, required this.hintText, required this.icon, required this.obscureText, this.keyboardType, this.controller, this.labelText,
  });

  final String hintText;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextEditingController? controller;
  final String? labelText;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.labelText!,
              style: GoogleFonts.montserrat(
                color: Colors.black, // Grey text
                fontSize: 16,
                fontWeight: FontWeight.w500, 
              ),
            ),
          ),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText ? _isObscured : false,
          style: TextStyle(color: Colors.black), // Text color
          decoration: InputDecoration(
            prefixIcon: Icon(widget.icon, color: Colors.grey), // Grey icon
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey[400]), // Grayer hint text
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _isObscured ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey), // Grey border
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey), // Default grey border
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2), // Highlighted border
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
        ),
      ],
    );
  }
}