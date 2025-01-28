import 'package:flutter/material.dart';

class HelloText extends StatelessWidget {
  const HelloText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Center(
          child: Text(
            'Hello !',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontFamily: 'pacifico',
              fontSize: 40,
            ),
          ),
        ),
        SizedBox(height: 5),
        Center(
          child: Text(
            'Best Place to connect with friends',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}
