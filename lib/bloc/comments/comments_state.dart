import "package:comments_app/models/comments_model.dart";
import "package:equatable/equatable.dart";
import "package:flutter/material.dart";

@immutable
abstract class CommentsState extends Equatable {}

class CommentsInitial extends CommentsState {
  CommentsInitial();

  @override
  List<Object?> get props => [];
}

class CommentsErrorState extends CommentsState {
  @override
  bool operator ==(Object other) => false;
  CommentsErrorState(this.errorMessage);
  final String errorMessage;
  @override
  List<Object?> get props => [];
}

class LoadingState extends CommentsState {
  LoadingState();
  @override
  List<Object?> get props => [];
}

class CommentsLoadedState extends CommentsState {
  CommentsLoadedState({required this.comments});
  final List<Comment> comments;

  @override
  List<Object?> get props => [];
}

class SignOutSuccessState extends CommentsState {
  SignOutSuccessState();
  @override
  List<Object?> get props => [];
}
