import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.hint,
      required this.onChanged,
      this.isPassword = false,
      this.prefixIcon,
      this.suffixIcon,
      this.suffixPressed,
      this.controller,
      this.inputType});

  IconData? prefixIcon;
  IconData? suffixIcon;
  final String hint;
  bool? isPassword;
  Function(String)? onChanged;
  VoidCallback? suffixPressed;
  TextInputType? inputType;
  TextEditingController? controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: Colors.red,
      onChanged: onChanged,
      obscureText: isPassword!,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(25),
        fillColor: Colors.white,
        focusColor: Colors.white,
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            suffixIcon,
          ),
          onPressed: suffixPressed,
        ),
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.red,
            )),
        filled: true,
      ),
    );
  }
}
