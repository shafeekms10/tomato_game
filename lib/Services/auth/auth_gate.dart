import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tomato_game/Services/auth/signin_or_signup.dart';
import 'package:tomato_game/Screens/home.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return Home();
          }
          else{
            return const SigninOrSignup();
          }
        },
      ),
    );
  }
}
