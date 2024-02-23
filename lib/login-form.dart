import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:market/main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:market/models/user-service.dart';
import 'package:market/navigation.dart';

final dio = Dio();
final storage = FlutterSecureStorage();


class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>{
  bool errorOccurred = false;

  @override
  Widget build(BuildContext context){
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Form'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[350],

          ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(height: 16.0),
                Visibility(
                  visible: errorOccurred, // Set to true when no error occurs
                  child:  const Text(
                    'User not found',
                    style: TextStyle(color: Colors.red),
                  ), // Replace with your actual widget
                ),
                ElevatedButton(
                      onPressed: () async {
                        //try{
                          await UserService.instance.fetchUser(emailController.value.text, passwordController.value.text);
                          print("mati");
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context){
                              return Navigation();
                            }),
                          );
                        //}
                        //catch(e){
                        //  setState(() {
                        //  errorOccurred = true;
                        //  });
                        //}


                      },
                      child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
