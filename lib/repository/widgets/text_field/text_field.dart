import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.mtController,
      required this.mHindText,
      required this.mKeyboardtype,
      this.mPreIcon,
      this.mSuffIcon});

  final TextInputType mKeyboardtype;
  final IconData? mPreIcon;
  final IconData? mSuffIcon;
  final String mHindText;
  final TextEditingController mtController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextFormField(
        controller: mtController,
        keyboardType: mKeyboardtype,
        decoration: InputDecoration(
          prefixIcon: Icon(
            // Icons.mail_outline,
            mPreIcon,
            color: Colors.grey,
          ),
          suffixIcon: Icon(
            // Icons.mail_outline,
            mSuffIcon,
            color: Colors.grey,
          ),
          border: InputBorder.none,
          hintText: mHindText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
