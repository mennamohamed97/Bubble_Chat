import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
//دي ال function المسؤولة عن ال Login
  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
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

  //  to track what happened in states
  @override
  void onChange(Change<LoginState> change) {
    print(change);
    super.onChange(change);
  }
}
