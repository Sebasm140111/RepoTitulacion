import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _register() {
    // Aquí podrías agregar lógica para validar y registrar con tu backend o Firebase
    print('Nombre: ${_nameController.text}');
    print('Correo: ${_emailController.text}');
    print('Cédula: ${_idController.text}');
    print('Contraseña: ${_passwordController.text}');

    // Luego rediriges a la pantalla de "pendiente de aprobación"
    Navigator.pushNamed(context, '/pendiente_rol');
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
              // Stack para llama sobre el marco con texto centrado
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    margin: const EdgeInsets.only(top: 40),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Center(
                      child: Text(
                        'Regístrate',
                        style: TextStyle(
                          fontSize: 20,
                          color: textoColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/llama.png',
                      height: 130,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 64),

              // Nombres completos
              TextField(
                controller: _nameController,
                style: TextStyle(color: textoColor),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: rojo,
                  prefixIcon: Icon(Icons.person, color: Colors.white),
                  labelText: 'Nombres Completos',
                  labelStyle: labelWithShadow,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: rojo),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Correo electrónico
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

              // Cédula
              TextField(
                controller: _idController,
                style: TextStyle(color: textoColor),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: rojo,
                  prefixIcon: Icon(Icons.credit_card, color: Colors.white),
                  labelText: 'Cédula',
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
              const SizedBox(height: 16),

              // Confirmar contraseña
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                style: TextStyle(color: textoColor),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: rojo,
                  prefixIcon: Icon(Icons.lock_outline, color: Colors.white),
                  labelText: 'Confirmar Contraseña',
                  labelStyle: labelWithShadow,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: rojo),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Botón registrar
              ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: fondoVino,
                  foregroundColor: Colors.white,
                  elevation: 6,
                  shadowColor: Colors.black45,
                  minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text('Registrar'),
              ),
              const SizedBox(height: 16),

              // Botón regresar
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  '← Regresar',
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
