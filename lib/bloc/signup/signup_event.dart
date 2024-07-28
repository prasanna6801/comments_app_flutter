import "package:equatable/equatable.dart";
import "package:flutter/material.dart";

@immutable
abstract class SignupEvent extends Equatable {}

class SignupLoadEvent extends SignupEvent {
  SignupLoadEvent(
      {required this.email, required this.name, required this.password});
  final String name;
  final String email;
  final String password;

  @override
  List<Object?> get props => [];
}

class SignupErrorEvent extends SignupEvent {
  SignupErrorEvent(this.errorMessage);
  final String errorMessage;
  @override
  List<Object?> get props => [];
}

class SignupSuccessEvent extends SignupEvent {
  SignupSuccessEvent(this.message);
  final String message;
  @override
  List<Object?> get props => [];
}

class LoadingEvent extends SignupEvent {
  LoadingEvent();
  @override
  List<Object?> get props => [];
}
