import 'package:flutter/material.dart';
import 'package:market/login-form.dart';
import 'package:market/register-form.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
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
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.background)),
                        child: Text("Log In", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 24),),
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
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.background)),
                        child: Text("Register", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 24),),
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
