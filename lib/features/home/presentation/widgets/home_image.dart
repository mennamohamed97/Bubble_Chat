import 'package:flutter/material.dart';

class HomeImage extends StatelessWidget {
  const HomeImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/home.png',
        height: 400,
        width: 400,
      ),
    );
  }
}
