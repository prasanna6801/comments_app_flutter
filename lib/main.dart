import 'package:comments_app/bloc/signup/signup_bloc.dart';
import 'package:comments_app/pages/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyC98puaqC3_YfyOF8G5PWotm2wpkDVjB0Q",
    appId: "1:730337304079:android:41d1489966825cda448d7a",
    messagingSenderId: "730337304079",
    projectId: "comments-4ca10",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, fontFamily: "Poppins"),
      home: BlocProvider(
          create: (context) => SignupBloc(), child: const SignupPage()),
    );
  }
}
