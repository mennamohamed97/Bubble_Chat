import 'package:flutter/material.dart';
import 'package:my_chat/features/home/presentation/widgets/home_image.dart';
import 'package:my_chat/features/home/presentation/widgets/login_button.dart';
import '../../../../core/utililes/constants.dart';
import '../widgets/hello_text.dart';
import '../widgets/logo.dart';
import '../widgets/register_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static String id = 'home page';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Logo(),
          HomeImage(),
          HelloText(),
          SizedBox(height: 40),
          LoginButton(),
          SizedBox(height: 20),
          RegisterButton(),
        ],
      ),
    );
  }
}
