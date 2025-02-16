import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is AuthLoginEvent) {
        emit(LoginLoading());
        try {
          UserCredential user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: event.email, password: event.password);
          emit(LoginSuccess());
        } on FirebaseAuthException catch (ex) {
          if (ex.code == 'user-not-found') {
            emit(LoginFailure(errorMessage: "User not found"));
          } else if (ex.code == 'wrong-password') {
            emit(LoginFailure(errorMessage: "Wrong password"));
          } else if (ex.code == 'invalid-credential') {
            emit(LoginFailure(errorMessage: "Wrong email or password"));
          } else {
            emit(LoginFailure(errorMessage: "Unknown error occurred"));
          }
        } catch (e) {
          emit(LoginFailure(errorMessage: "something went wrong"));
        }
      }
    });
  }
}
