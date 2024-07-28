import "package:equatable/equatable.dart";
import "package:flutter/material.dart";

@immutable
abstract class SignupState extends Equatable {}

class SignUpInitial extends SignupState {
  SignUpInitial();

  @override
  List<Object?> get props => [];
}

class SignupErrorState extends SignupState {
  SignupErrorState(this.errorMessage);
  final String errorMessage;
  @override
  List<Object?> get props => [];
}

class SignupSuccessState extends SignupState {
  SignupSuccessState(this.message);
  final String message;
  @override
  List<Object?> get props => [];
}

class LoadingState extends SignupState {
  LoadingState();
  @override
  List<Object?> get props => [];
}
