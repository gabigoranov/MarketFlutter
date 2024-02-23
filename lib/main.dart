import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:market/authentication-wrapper.dart';
import 'navigation.dart';

final storage = FlutterSecureStorage();

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyB22nSiqPthWDIWt5XEtHXESXCzNNhecRU",
        appId: "1:847650161276:android:82cabff8157ffc19437ff9",
        messagingSenderId: "847650161276",
        projectId: "market-229ca",
        storageBucket: 'market-229ca.appspot.com',
      )
  );


  runApp( MyApp() );
}



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
        ),
        useMaterial3: true,
        // Define the default brightness and colors.
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFFFFF),
          primary: const Color(0xff5186c3),
          background: const Color(0xffFAFAFA),
        ),
      ),
      home: const AuthenticationWrapper(),
    );
  }
}




