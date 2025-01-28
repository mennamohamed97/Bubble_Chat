import 'package:flutter/material.dart';
import '../../../../core/utililes/custom_button.dart';
import '../../../auth/signup/presentation/screen/resgister_page.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomButton(
        onTap: () {
          Navigator.pushNamed(context, RegisterPage.id);
        },
        text: 'Register',
        isLogin: false,
      ),
    );
  }
}
