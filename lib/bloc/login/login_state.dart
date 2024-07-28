import "package:equatable/equatable.dart";
import "package:flutter/material.dart";

@immutable
abstract class LoginState extends Equatable {}

class LoginInitial extends LoginState {
  LoginInitial();

  @override
  List<Object?> get props => [];
}

class LoginErrorState extends LoginState {
  @override
  bool operator ==(Object other) => false;
  LoginErrorState(this.errorMessage);
  final String errorMessage;
  @override
  List<Object?> get props => [];
}

class LoginSuccessState extends LoginState {
  @override
  bool operator ==(Object other) => false;
  LoginSuccessState(this.message);
  final String message;
  @override
  List<Object?> get props => [];
}
class LoadingState extends LoginState {
  LoadingState();
  @override
  List<Object?> get props => [];
}