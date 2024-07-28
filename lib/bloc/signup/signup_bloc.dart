import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comments_app/bloc/signup/signup_event.dart';
import 'package:comments_app/bloc/signup/signup_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter_bloc/flutter_bloc.dart";

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignUpInitial()) {
    on<SignupErrorEvent>((event, emit) {
      emit(SignupErrorState(event.errorMessage));
    });
    on<SignupSuccessEvent>((event, emit) {
      emit(SignupSuccessState(event.message));
    });
    on<SignupLoadEvent>((event, emit) async {
      await registerWithEmailAndPassword(
          event.email, event.password, event.name);
    });
    on<LoadingEvent>((event, emit) {
      emit(LoadingState());
    });
  }

  registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      add(LoadingEvent());
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': email,
          'name': name,
        });
        add(SignupSuccessEvent("Authenticated"));
      }
    } catch (e) {
      add(SignupErrorEvent(e.toString()));
    }
  }
}
