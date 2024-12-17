import 'package:final_exam_project/shared/theme.dart';
import 'package:flutter/material.dart';

class CustomizedButton extends StatefulWidget {
  final double height;
  final String text;
  final VoidCallback onTap;
  const CustomizedButton({
    super.key,
    required this.height,
    this.text = "Sign In",
    required this.onTap,
  });

  @override
  State<CustomizedButton> createState() => _CustomizedButtonState();
}

class _CustomizedButtonState extends State<CustomizedButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultRadius),
          color: kPurpleColor,
        ),
        child: TextButton(
          onPressed: () {
            widget.onTap();
          },
          child: Text(
            widget.text,
            style: whiteTextStyle.copyWith(
              fontSize: 24,
              fontWeight: bold,
            ),
          ),
        ),
      ),
    );
  }
}
