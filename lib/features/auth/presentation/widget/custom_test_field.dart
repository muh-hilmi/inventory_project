import 'package:flutter/material.dart';
import 'package:inventory_project/core/theme/color.dart';

class CustomTestField extends StatelessWidget {
  CustomTestField(
      {super.key,
      required this.hintText,
      this.obscureText = false,
      required this.controller,
      this.suffixIcon});

  final bool obscureText;
  final String hintText;
  final TextEditingController controller;
  Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: AppColor.bgLight,
            border: InputBorder.none,
            hintText: hintText),
        validator: (value) {
          if (value!.isEmpty) {
            return 'this form cannot be empty';
          }
          if (suffixIcon != null) {
            if (value.length < 8) {
              return 'password must contain at least 8 characters';
            }
          }
          return null;
        },
      ),
    );
  }
}
