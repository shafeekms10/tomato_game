import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tomato_game/Components/my_button.dart';
import 'package:tomato_game/Components/my_text_field.dart';
import 'package:tomato_game/Services/auth/auth_service.dart';

class SignIn extends StatefulWidget {
  final void Function()? onTap;
  const SignIn({super.key, required this.onTap});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailAndPassword(
          emailController.text,
          passwordController.text
      );
    }
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color.fromRGBO(239, 118, 73, 0.6), Color.fromRGBO(239, 118, 73, 0.2)])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 220,
                    width: 200,
                    child: Image.asset(
                      'assets/logo.png',
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text('Tomato Mystery',
                    style: TextStyle(
                      color: Color.fromRGBO(234, 77, 26, 1),
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text('Challenge',
                    style: TextStyle(
                      color: Color.fromRGBO(234, 77, 26, 1),
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Opacity(
                    opacity: 0.8,
                    child: Container(
                      height: 410,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(17)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            const SizedBox(height: 10,),
                            const Text('Please Sign In to Your Account',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                              ),
                            ),
                            const SizedBox(height: 20,),
                            SizedBox(
                              width: 250,
                              child: MyTextField(
                                  controller: emailController,
                                  hintText: 'Email',
                                  icon: FontAwesomeIcons.envelope,
                                  obscureText: false,
                              )
                            ),
                            const SizedBox(height: 20,),
                            SizedBox(
                              width: 250,
                              child: MyTextField(
                                controller: passwordController,
                                hintText: 'Password',
                                icon: FontAwesomeIcons.lock,
                                obscureText: true,
                              )
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 40, 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('Forgot Password?',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold
                                    ),
                                  )
                                ],
                              ) ,
                            ),
                            const SizedBox(height: 10,),
                            MyButton(onTap: signIn, text: 'Sign In'),
                            const SizedBox(height: 27,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Don\'t have an account? ',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(width: 5,),
                                GestureDetector(
                                  onTap: widget.onTap,
                                  child: const Text('Sign Up',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(234, 77, 26, 1),
                                      ),
                                    ),
                                ),
                              ],
                            ),
                          ]
                      ),
                    ),
                  )
                ],
              ),
            )
        )
    );
  }
}
