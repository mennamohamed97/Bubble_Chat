import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_chat/features/auth/login/presentation/screen/login_page.dart';
import 'package:my_chat/features/auth/signup/presentation/controller/bloc/signup_bloc.dart';
import 'package:my_chat/features/chat/presentation/screen/chat_page.dart';

import '../../../../../core/utililes/constants.dart';
import '../../../../../core/utililes/show_snack_bar.dart';
import '../../../../../core/utililes/custom_button.dart';
import '../../../../../core/utililes/custom_text_field.dart';

class RegisterPage extends StatelessWidget {
  String? email;

  String? password;

  bool isLoading = false;
  static String id = 'RegisterPage';

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // change SignupCubit with SignupBloc
    return BlocConsumer<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupLoading) {
          isLoading = true;
        } else if (state is SignupSuccess) {
          Navigator.pushNamed(
            context,
            ChatPage.id,
            arguments: email,
          );
          isLoading = false;
        } else if (state is SignupFailure) {
          showSnackBar(context, state.errorMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kBackgroundColor,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.blue,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      'Hi !',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'pacifico',
                        fontSize: 50,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Create a new account !',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    CustomFormTextField(
                      onChanged: (data) {
                        email = data;
                      },
                      hintText: 'Email',
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    CustomFormTextField(
                      onChanged: (data) {
                        password = data;
                      },
                      hintText: 'Password',
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    CustomButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          // change trigger from cubit to bloc
                          // BlocProvider.of<SignupCubit>(context)
                          //     .registerUser(email: email!, password: password!);
                          BlocProvider.of<SignupBloc>(context).add(
                              AuthSignupEvent(
                                  email: email!, password: password!));
                        } else {}
                      },
                      text: 'REGISTER',
                      isLogin: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'already have an account?',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, LoginPage.id);
                          },
                          child: const Text(
                            '  Login',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
