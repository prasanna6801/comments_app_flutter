import 'package:comments_app/bloc/comments/comments_bloc.dart';
import 'package:comments_app/bloc/comments/comments_event.dart';
import 'package:comments_app/bloc/comments/comments_state.dart';
import 'package:comments_app/bloc/signup/signup_bloc.dart';
import 'package:comments_app/models/comments_model.dart';
import 'package:comments_app/pages/signup_page.dart';
import 'package:comments_app/themes/texttheme.dart';
import 'package:comments_app/widgets/appbar.dart';
import 'package:comments_app/themes/colorscheme.dart';
import 'package:comments_app/widgets/toastwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({super.key});
  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  CommentsBloc? commentsBloc;
  List<Comment> comments = [];
  @override
  void initState() {
    commentsBloc = BlocProvider.of<CommentsBloc>(context);
    commentsBloc?.add(CommentsLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.screenBackgroundcolor,
        resizeToAvoidBottomInset: true,
        appBar: AppBarWidget().appbarWidget(
            context, Theme.of(context).colorScheme.primaryBlueColor,
            titleColor: Theme.of(context).colorScheme.screenBackgroundcolor,
            actionWidgets: [
              IconButton(
                  padding: const EdgeInsets.only(bottom: 5),
                  onPressed: () {
                    commentsBloc?.add(SignOutEvent());
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ))
            ]),
        body: BlocConsumer<CommentsBloc, CommentsState>(
            listener: (context, state) {
          if (state is CommentsErrorState) {
            WidgetsBinding.instance.addPostFrameCallback((_) => Toastwidget()
                .toastWidget(
                    context: context,
                    text: state.errorMessage,
                    isErrorToast: true));
          }
          if (state is SignOutSuccessState) {
            WidgetsBinding.instance
                .addPostFrameCallback((_) => Toastwidget().toastWidget(
                      context: context,
                      text: "Signed Out Successfully",
                    ));
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                      create: (context) => SignupBloc(),
                      child: const SignupPage()),
                ));
          }
        }, builder: (context, state) {
          if (state is CommentsLoadedState) {
            comments = state.comments;
          }

          if (state is CommentsErrorState) {
            return Center(
              child: Text(
                "No Comments Found",
                style: Theme.of(context)
                    .textTheme
                    .regularTextStyle(context, fontweight: FontWeight.w700),
              ),
            );
          }

          if (state is LoadingState) {
            comments = List.filled(
                7,
                Comment(
                    postId: 0,
                    id: 1,
                    name: "test",
                    email: 'test@gmail.com',
                    body:
                        "facilis repellendus inventore aperiam corrupti saepe culpa velit\ndolores sint ut\naut quis voluptates iure et a\nneque harum quia similique sunt eum voluptatem a"));
          }
          return Skeletonizer(
            enabled: state is LoadingState,
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                  child: Card(
                    color: Colors.white,
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 12, left: 10, right: 20, bottom: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.titleColor,
                            child: Text(comments[index].name[0].toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .regularTextStyle(
                                      context,
                                      fontweight: FontWeight.w700,
                                    )),
                          ),
                          const SizedBox(
                            width: 13,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                getTextWidget("Name", comments[index].name),
                                const SizedBox(
                                  height: 3,
                                ),
                                getTextWidget("Email", comments[index].email),
                                const SizedBox(
                                  height: 5,
                                ),
                                Flexible(
                                  child: Tooltip(
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black),
                                    triggerMode: TooltipTriggerMode.tap,
                                    message: comments[index].body,
                                    child: Text(comments[index].body,
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        style: Theme.of(context)
                                            .textTheme
                                            .regularTextStyle(context,
                                                fontSize: 14)),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
          // } else {
          //   return Container();
          // }
        }),
      ),
    );
  }

  getTextWidget(String titleText, String contentText) {
    return Tooltip(
      message: contentText,
      decoration: const BoxDecoration(color: Colors.black),
      triggerMode: TooltipTriggerMode.tap,
      child: RichText(
          overflow: TextOverflow.ellipsis,
          text: TextSpan(children: [
            TextSpan(
                text: titleText,
                style: Theme.of(context).textTheme.regularTextStyle(context,
                    fontSize: 14,
                    textColor: Theme.of(context).colorScheme.titleColor,
                    fontStyle: FontStyle.italic)),
            TextSpan(
                text: " : ",
                style: Theme.of(context).textTheme.regularTextStyle(context,
                    fontSize: 14,
                    textColor: Theme.of(context).colorScheme.titleColor)),
            TextSpan(
                text: contentText,
                style: Theme.of(context).textTheme.regularTextStyle(context,
                    fontweight: FontWeight.w700, fontSize: 14))
          ])),
    );
  }
}
