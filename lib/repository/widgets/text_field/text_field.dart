import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.mtController,
      this.myValidator,
      required this.mHindText,
      required this.mKeyboardtype,
      this.mPreIcon,
      required this.obs,
      this.obsText = "*",
      this.mSuffIcon});

  final TextInputType mKeyboardtype;
  final IconData? mPreIcon;
  final IconData? mSuffIcon;
  final String mHindText;
  final String obsText;
  final TextEditingController mtController;
  String? Function(String?)? myValidator;
  bool obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 6, left: 13),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextFormField(
        obscureText: obs,
        obscuringCharacter: obsText,
        validator: myValidator,
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
