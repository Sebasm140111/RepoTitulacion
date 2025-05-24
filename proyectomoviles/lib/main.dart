import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:proyectomoviles/Admin_Dashboard.dart';
import 'login.dart';
import 'register.dart'; 
import 'recoverpass.dart';
import 'newpass.dart';
import 'pendiente.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

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
        '/admin_dashboard':(context)=>AdminHomeScreen(),
      },
    );
  }
}