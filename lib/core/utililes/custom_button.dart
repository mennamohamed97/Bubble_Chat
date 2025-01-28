import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final bool isLogin;

  const CustomButton(
      {Key? key, this.onTap, required this.text, required this.isLogin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isLogin ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isLogin ? Colors.transparent : Colors.blue,
          ),
        ),
        width: 300,
        height: 55,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: isLogin ? Colors.white : Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 17),
          ),
        ),
      ),
    );
  }
}
