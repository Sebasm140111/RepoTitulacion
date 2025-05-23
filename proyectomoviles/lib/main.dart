import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart'; 
import 'recoverpass.dart';
import 'newpass.dart';
import 'pendiente.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/recover':(context)=>RecoverPasswordScreen(),
        '/newpass':(context)=>NewPasswordScreen(),
        '/pendiente_rol':(context)=>PendingApprovalScreen(),
      },
    );
  }
}