import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:market/services/authentication_wrapper.dart';
import 'package:market/services/offer_service.dart';
import 'package:market/views/onboarding.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

const storage = FlutterSecureStorage();

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async {
  

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


  runApp( const MyApp() );
}



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String serverUrl = "https://farmers-market.somee.com/notificationHub";
  // Creates the connection by using the HubConnectionBuilder.
  late HubConnection hubConnection;


  @override
  void initState(){
    super.initState();
    hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
    OfferService.instance.loadOffers();
    initSignalR();
  }

  void initSignalR() async{
    await hubConnection.start();
    print('connected to signalr');
    hubConnection.on('ReceiveMessage', (arguments) {
      print(arguments);
    });
  }


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
          seedColor: const Color(0xffFFFFFF),
          secondary: const Color(0xff40B886),
          primary: const Color(0xff2C92FF),
          background: const Color(0xffFFFFFF),
          tertiary: const Color(0xff2C2B2B)
        ),
      ),
      home: const AuthenticationWrapper(),
    );
  }
}




