import 'package:flutter/material.dart';

class ButttonWidgetApp extends StatelessWidget {
  const ButttonWidgetApp({
    super.key,
    this.btnColor = Colors.deepOrange,
    required this.btnName,
    this.btnWidth = 200,
    required this.onTap,
  });

  final Color btnColor;
  final String btnName;
  final double btnWidth;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(25),
        width: btnWidth,
        decoration: BoxDecoration(
            color: btnColor, borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            btnName,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
