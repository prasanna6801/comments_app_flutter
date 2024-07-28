import 'package:comments_app/bloc/comments/comments_bloc.dart';
import 'package:comments_app/bloc/login/login_bloc.dart';
import 'package:comments_app/bloc/login/login_event.dart';
import 'package:comments_app/bloc/login/login_state.dart';
import 'package:comments_app/bloc/signup/signup_bloc.dart';
import 'package:comments_app/pages/comments_page.dart';
import 'package:comments_app/widgets/appbar.dart';
import 'package:comments_app/widgets/bottom_widget.dart';
import 'package:comments_app/themes/colorscheme.dart';
import 'package:comments_app/pages/signup_page.dart';
import 'package:comments_app/widgets/textfield_widget.dart';
import 'package:comments_app/widgets/toastwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  LoginBloc? loginBloc;
  @override
  void initState() {
    loginBloc = BlocProvider.of<LoginBloc>(context);
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
            context, Theme.of(context).colorScheme.screenBackgroundcolor),
        body: BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
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
                          color: Theme.of(context).colorScheme.primaryBlueColor,
                        ))
                      ])),
                );
              },
            );
          }
          if (state is LoginErrorState) {
            Navigator.pop(context);
            WidgetsBinding.instance.addPostFrameCallback((_) => Toastwidget()
                .toastWidget(
                    context: context,
                    text: state.errorMessage,
                    isErrorToast: true));
          }
          if (state is LoginSuccessState) {
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
        }, builder: (context, state) {
          return Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
        }),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(top: 130, bottom: 70.0),
            child: BottomWidget(
              buttonPressedCallback: () {
                if (formKey.currentState?.validate() ?? false) {
                  loginBloc?.add(LoginLoadEvent(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim()));
                }
              },
              textPressedCallback: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                          create: (context) => SignupBloc(),
                          child: const SignupPage()),
                    ));
              },
              actionText: "Signup",
              hintText: "New here?",
              buttonText: "Login",
            )),
      ),
    );
  }
}
