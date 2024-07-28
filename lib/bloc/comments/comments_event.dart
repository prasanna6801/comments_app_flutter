import "package:comments_app/models/comments_model.dart";
import "package:equatable/equatable.dart";
import "package:flutter/material.dart";

@immutable
abstract class CommentsEvent extends Equatable {}

class CommentsLoadEvent extends CommentsEvent {
  CommentsLoadEvent();

  @override
  List<Object?> get props => [];
}

class CommentsErrorEvent extends CommentsEvent {
  CommentsErrorEvent(this.errorMessage);
  final String errorMessage;
  @override
  List<Object?> get props => [];
}

class LoadingEvent extends CommentsEvent {
  LoadingEvent();
  @override
  List<Object?> get props => [];
}

class CommentsLoadedEvent extends CommentsEvent {
  CommentsLoadedEvent({required this.comments});
  final List<Comment> comments;

  @override
  List<Object?> get props => [];
}

class SignOutEvent extends CommentsEvent {
  SignOutEvent();

  @override
  List<Object?> get props => [];
}
class SignOutSuccessEvent extends CommentsEvent {
  SignOutSuccessEvent();
  @override
  List<Object?> get props => [];
}