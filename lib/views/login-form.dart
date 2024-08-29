import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:market/services/user-service.dart';
import 'package:market/views/navigation.dart';

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
        decoration: const BoxDecoration(
          color: Colors.white,

        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
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
                const SizedBox(height: 16.0,),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () async {
                              //try{
                                await UserService.instance.login(emailController.value.text, passwordController.value.text);
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context){
                                    return Navigation(index: 0,);
                                  }),
                                );
                              //}
                              //catch(e){
                              //  setState(() {
                              //    errorOccurred = true;
                              //  });
                              //}
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blue,
                              shadowColor: Colors.black,
                              elevation: 4.0,
                            ),
                            child: Text("Login", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 24),),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
