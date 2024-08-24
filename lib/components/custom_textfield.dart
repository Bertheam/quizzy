import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final Icon? icon;
  final TextEditingController controller;
  final bool? setObscure;
  final String placeholder;
  final TextInputType? keyboardType;
  const CustomTextfield({super.key,required this.placeholder, required this.controller, this.icon, this.setObscure, this.keyboardType});

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12)),
      child:  TextField(
        obscureText: widget.setObscure ?? false,

        keyboardType: widget.keyboardType,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.placeholder,
          hintStyle: const TextStyle(
              color: Colors.black38, fontWeight: FontWeight.bold),
          prefixIcon: widget.icon,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
