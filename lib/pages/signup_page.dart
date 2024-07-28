import 'package:comments_app/bloc/comments/comments_bloc.dart';
import 'package:comments_app/bloc/login/login_bloc.dart';
import 'package:comments_app/bloc/signup/signup_bloc.dart';
import 'package:comments_app/bloc/signup/signup_event.dart';
import 'package:comments_app/bloc/signup/signup_state.dart';
import 'package:comments_app/pages/comments_page.dart';
import 'package:comments_app/widgets/appbar.dart';
import 'package:comments_app/widgets/bottom_widget.dart';
import 'package:comments_app/themes/colorscheme.dart';
import 'package:comments_app/pages/login_page.dart';
import 'package:comments_app/widgets/textfield_widget.dart';
import 'package:comments_app/widgets/toastwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  SignupBloc? signupBloc;
  @override
  void initState() {
    signupBloc = BlocProvider.of<SignupBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (onDidPop) {
        SystemNavigator.pop();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.screenBackgroundcolor,
        resizeToAvoidBottomInset: true,
        appBar: AppBarWidget().appbarWidget(
            context, Theme.of(context).colorScheme.screenBackgroundcolor),
        body: BlocConsumer<SignupBloc, SignupState>(
          listener: (context, state) {
            if (state is LoadingState) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return PopScope(
                    canPop: false,
                    child: Container(
                        color: Colors.transparent,
                        child: Stack(children: [
                          Center(
                              child: CupertinoActivityIndicator(
                            color:
                                Theme.of(context).colorScheme.primaryBlueColor,
                          ))
                        ])),
                  );
                },
              );
            }
            if (state is SignupErrorState) {
              Navigator.pop(context);
              WidgetsBinding.instance.addPostFrameCallback((_) => Toastwidget()
                  .toastWidget(
                      context: context,
                      text: state.errorMessage,
                      isErrorToast: true));
            }
            if (state is SignupSuccessState) {
              Navigator.pop(context);
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => Toastwidget().toastWidget(
                        context: context,
                        text: state.message,
                      ));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                        create: (context) => CommentsBloc(),
                        child: const CommentsPage()),
                  ));
            }
          },
          builder: (context, state) {
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFieldWidget(
                    hintText: "Name",
                    inputType: TextInputType.text,
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldWidget(
                    hintText: "Email",
                    inputType: TextInputType.emailAddress,
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldWidget(
                    hintText: "Password",
                    inputType: TextInputType.visiblePassword,
                    controller: passwordController,
                  ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(top: 130, bottom: 70.0),
            child: BottomWidget(
              buttonPressedCallback: () {
                if (formKey.currentState?.validate() ?? false) {
                  signupBloc?.add(SignupLoadEvent(
                      email: emailController.text.trim(),
                      name: nameController.text.trim(),
                      password: passwordController.text.trim()));
                }
              },
              textPressedCallback: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                          create: (context) => LoginBloc(),
                          child: const LoginPage()),
                    ));
              },
              actionText: "Login",
              hintText: "Already have an account?",
              buttonText: "Signup",
            )),
      ),
    );
  }
}
