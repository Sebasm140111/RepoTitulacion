import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() async {
    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      // Autenticación con Firebase
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Obtener UID
      final uid = credential.user!.uid;

      // Consultar datos del usuario en Firestore
      final doc = await FirebaseFirestore.instance.collection('usuarios').doc(uid).get();

      if (!doc.exists) {
        throw FirebaseAuthException(code: 'user-data-not-found', message: 'Usuario sin datos en Firestore.');
      }

      final data = doc.data()!;
      final rol = data['rol'];
      final nombre = data['nombre'];

      // Redirección según rol
      if (rol == 'Administrador') {
        Navigator.pushNamed(context, '/admin_dashboard', arguments: {'nombre': nombre});
      } else if (rol == 'Estudiante') {
        Navigator.pushNamed(context, '/estudiante_dashboard', arguments: {'nombre': nombre});
      } else if (rol == 'Secretario') {
        Navigator.pushNamed(context, '/secretario_dashboard', arguments: {'nombre': nombre});
      } else {
        Navigator.pushNamed(context, '/pendiente_rol');
      }
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(e.message ?? 'Ocurrió un error'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            )
          ],
        ),
      );
    }
  }

  void _recoverPassword() {
    Navigator.pushNamed(context, '/recover');
  }

  @override
  Widget build(BuildContext context) {
    const rojo = Color(0xFFFF3B30);
    const textoColor = Color(0xFF403535);
    const fondoVino = Color(0xFF6E2C2C);

    TextStyle labelWithShadow = TextStyle(
      color: Colors.white,
      fontSize: 14,
      shadows: [
        Shadow(
          offset: Offset(1, 1),
          blurRadius: 1,
          color: Colors.black45,
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black12),
                ),
                child: Text(
                  'Bienvenidos a RepoTitulación',
                  style: TextStyle(
                    fontSize: 20,
                    color: textoColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Image.asset(
                'assets/llama.png',
                height: 150,
              ),
              const SizedBox(height: 32),

              // Email
              TextField(
                controller: _emailController,
                style: TextStyle(color: textoColor),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: rojo,
                  prefixIcon: Icon(Icons.email, color: Colors.white),
                  labelText: 'Correo Electrónico',
                  labelStyle: labelWithShadow,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: rojo),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Contraseña
              TextField(
                controller: _passwordController,
                obscureText: true,
                style: TextStyle(color: textoColor),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: rojo,
                  prefixIcon: Icon(Icons.lock, color: Colors.white),
                  labelText: 'Contraseña',
                  labelStyle: labelWithShadow,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: rojo),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/newpass');
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: rojo,
                    side: BorderSide(color: rojo),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  icon: Icon(Icons.lock_open, size: 16),
                  label: Text('Recuperar contraseña'),
                ),
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: fondoVino,
                  foregroundColor: Colors.white,
                  elevation: 6,
                  shadowColor: Colors.black45,
                  minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text('Iniciar Sesión'),
              ),
              const SizedBox(height: 16),

              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text(
                  '¿No tienes cuenta? Regístrate',
                  style: TextStyle(color: textoColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
