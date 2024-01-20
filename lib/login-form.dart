import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:market/main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:market/models/user-service.dart';

final dio = Dio();
final storage = FlutterSecureStorage();


class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>{

  @override
  Widget build(BuildContext context){
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Form'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[350],

          ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value){},
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  validator: (value) {},
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                      onPressed: () async {
                        await UserService.instance.fetchUser(_emailController.value.text, _passwordController.value.text);
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context){
                            return const Main();
                          }),
                        );
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
