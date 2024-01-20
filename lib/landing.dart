import 'package:flutter/material.dart';
import 'package:market/login-form.dart';
import 'package:market/register-form.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: const Color(0xff5186c3),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/logo.png'),
              fit: BoxFit.contain,
            ),

          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                      child: TextButton(
                        onPressed: (){
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context){
                              return const LoginForm();
                            }),
                          );
                        },
                        style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0xffFAFAFA))),
                        child: const Text("Log In", style: TextStyle(color: Color(0xff5186c3), fontSize: 24),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: (){
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context){
                              return const RegisterForm();
                            }),
                          );
                        },
                        style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0xffFAFAFA))),
                        child: const Text("Register", style: TextStyle(color: Color(0xff5186c3), fontSize: 24),),
                      ),
                    ),


                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}
