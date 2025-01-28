import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_chat/core/services/firebase/simple_bloc_observer.dart';
import 'package:my_chat/features/auth/login/presentation/controller/bloc/login_bloc.dart';
import 'package:my_chat/features/auth/login/presentation/controller/cubit/login_cubit.dart';
import 'package:my_chat/features/auth/signup/presentation/controller/bloc/signup_bloc.dart';
import 'package:my_chat/features/auth/signup/presentation/controller/cubit/signup_cubit.dart';
import 'package:my_chat/features/chat/presentation/controller/chat_cubit.dart';
import 'package:my_chat/features/chat/presentation/screen/chat_page.dart';
import 'package:my_chat/features/home/presentation/screen/home_page.dart';
import 'package:my_chat/features/auth/login/presentation/screen/login_page.dart';
import 'package:my_chat/features/auth/signup/presentation/screen/resgister_page.dart';

import 'core/services/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyChat());
}

class MyChat extends StatelessWidget {
  const MyChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => SignupCubit(),
        ),
        BlocProvider(
          create: (context) => SignupBloc(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          HomePage.id: (context) => const HomePage(),
          LoginPage.id: (context) => LoginPage(),
          RegisterPage.id: (context) => RegisterPage(),
          ChatPage.id: (context) => ChatPage()
        },
        initialRoute: HomePage.id,
      ),
    );
  }
}
