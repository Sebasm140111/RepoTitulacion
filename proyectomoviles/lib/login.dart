import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    print('Email: ${_emailController.text}');
    print('Password: ${_passwordController.text}');
  }

  void _recoverPassword() {
  Navigator.pushNamed(context, '/recover');
  }


  @override
  Widget build(BuildContext context) {
    const rojo = Color(0xFFFF3B30);
    const textoColor = Color(0xFF403535);
    const fondoVino = Color(0xFF6E2C2C);

    // Estilo de sombra para etiquetas
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
              // Encabezado con marco suave
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

              // Imagen de la llama
              Image.asset(
                'assets/llama.png',
                height: 150,
              ),
              const SizedBox(height: 32),

              // Campo de correo electrónico
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

              // Campo de contraseña
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

              // Botón de recuperar contraseña
              Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton.icon(
                //onPressed: _recoverPassword,
                  onPressed: () {
                   Navigator.pushNamed(context, '/newpass'); // Para probar la pantalla de newpass -> Se activa desde el link de correo
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

              // Botón de iniciar sesión con sombra
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

              // Botón de registrarse
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
