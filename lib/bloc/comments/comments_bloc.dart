import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:comments_app/bloc/comments/comments_event.dart';
import 'package:comments_app/bloc/comments/comments_state.dart';
import 'package:comments_app/models/comments_model.dart';
import "package:flutter_bloc/flutter_bloc.dart";

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final String apiUrl = "https://jsonplaceholder.typicode.com/comments";
  CommentsBloc() : super(CommentsInitial()) {
    on<CommentsErrorEvent>((event, emit) {
      emit(CommentsErrorState(event.errorMessage));
    });
    on<LoadingEvent>((event, emit) {
      emit(LoadingState());
    });
    on<CommentsLoadEvent>((event, emit) async {
      await fetchComments();
    });
    on<CommentsLoadedEvent>((event, emit) {
      emit(CommentsLoadedState(comments: event.comments));
    });
    on<SignOutEvent>((event, emit) async {
      await signOut();
    });
    on<SignOutSuccessEvent>((event, emit) {
      emit(SignOutSuccessState());
    });
  }

  fetchComments() async {
    add(LoadingEvent());
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Comment> comments =
          body.map((dynamic item) => Comment.fromJson(item)).toList();
      add(CommentsLoadedEvent(comments: comments));
    } else {
      add(CommentsErrorEvent(response.reasonPhrase ?? "Something Went Wrong"));
    }
  }

  signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      add(SignOutSuccessEvent());
    } catch (e) {
      add(CommentsErrorEvent(e.toString()));
    }
  }
}
