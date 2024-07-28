import 'package:comments_app/bloc/login/login_event.dart';
import 'package:comments_app/bloc/login/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter_bloc/flutter_bloc.dart";

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginErrorEvent>((event, emit) {
      emit(LoginErrorState(event.errorMessage));
    });
    on<LoginSuccessEvent>((event, emit) {
      emit(LoginSuccessState(event.message));
    });
    on<LoadingEvent>((event, emit) {
      emit(LoadingState());
    });
    on<LoginLoadEvent>((event, emit) async {
      await signInWithEmailAndPassword(event.email, event.password);
    });
  }

  signInWithEmailAndPassword(String email, String password) async {
    try {
      add(LoadingEvent());
      UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (result.user != null) {
        add(LoginSuccessEvent("Authenticated"));
      }
    } catch (e) {
      add(LoginErrorEvent(e.toString()));
    }
  }
}
