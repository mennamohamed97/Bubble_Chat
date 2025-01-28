import 'package:flutter/material.dart';
import '../../../../core/utililes/custom_button.dart';
import '../../../auth/login/presentation/screen/login_page.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: CustomButton(
        onTap: () {
          Navigator.pushNamed(context, LoginPage.id);
        },
        text: 'LOGIN',
        isLogin: true,
      ),
    );
  }
}
