import "package:equatable/equatable.dart";
import "package:flutter/material.dart";

@immutable
abstract class LoginEvent extends Equatable {}

class LoginLoadEvent extends LoginEvent {
  LoginLoadEvent({required this.email, required this.password});
  final String email;
  final String password;

  @override
  List<Object?> get props => [];
}

class LoginErrorEvent extends LoginEvent {
  LoginErrorEvent(this.errorMessage);
  final String errorMessage;
  @override
  List<Object?> get props => [];
}

class LoginSuccessEvent extends LoginEvent {
  LoginSuccessEvent(this.message);
  final String message;
  @override
  List<Object?> get props => [];
}
class LoadingEvent extends LoginEvent {
  LoadingEvent();
  @override
  List<Object?> get props => [];
}