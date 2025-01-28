import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupEvent>((event, emit) async {
      if (event is AuthSignupEvent) {
        emit(SignupLoading());

        try {
          UserCredential user = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: event.email, password: event.password);
          emit(SignupSuccess());
        } on FirebaseAuthException catch (ex) {
          if (ex.code == 'weak-password') {
            emit(SignupFailure(errorMessage: "weak password"));
          } else if (ex.code == 'email-already-in-use') {
            emit(SignupFailure(errorMessage: "email already exists"));
          } else {
            emit(SignupFailure(errorMessage: "Unknown error occurred"));
          }
        } catch (e) {
          emit(SignupFailure(
              errorMessage: "There was an error please try again"));
        }
      }
    });
  }
}
