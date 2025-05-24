import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  final _auth = FirebaseAuth.instance;

  void _register() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (!email.endsWith('@espoch.edu.ec')) {
      _showMessage('El correo debe pertenecer al dominio @espoch.edu.ec');
      return;
    }

    if (password != confirmPassword) {
      _showMessage('Las contraseñas no coinciden');
      return;
    }

    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      _showMessage('Registro exitoso');
      Navigator.pushNamed(context, '/pendiente_rol');
    } on FirebaseAuthException catch (e) {
      _showMessage(e.message ?? 'Error al registrar');
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
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
        Shadow(offset: Offset(1, 1), blurRadius: 1, color: Colors.black45),
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
                    child: Image.asset('assets/llama.png', height: 130),
                  ),
                ],
              ),
              const SizedBox(height: 64),

              _buildTextField(_nameController, Icons.person, 'Nombres Completos', rojo, textoColor, labelWithShadow),
              const SizedBox(height: 16),
              _buildTextField(_emailController, Icons.email, 'Correo Electrónico', rojo, textoColor, labelWithShadow),
              const SizedBox(height: 16),
              _buildTextField(_idController, Icons.credit_card, 'Cédula', rojo, textoColor, labelWithShadow),
              const SizedBox(height: 16),
              _buildPasswordField(_passwordController, Icons.lock, 'Contraseña', rojo, textoColor, labelWithShadow),
              const SizedBox(height: 16),
              _buildPasswordField(_confirmPasswordController, Icons.lock_outline, 'Confirmar Contraseña', rojo, textoColor, labelWithShadow),
              const SizedBox(height: 32),

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
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('← Regresar', style: TextStyle(color: textoColor)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, IconData icon, String label, Color fillColor, Color textColor, TextStyle labelStyle) {
    return TextField(
      controller: controller,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        prefixIcon: Icon(icon, color: Colors.white),
        labelText: label,
        labelStyle: labelStyle,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: fillColor), borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, IconData icon, String label, Color fillColor, Color textColor, TextStyle labelStyle) {
    return TextField(
      controller: controller,
      obscureText: true,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        prefixIcon: Icon(icon, color: Colors.white),
        labelText: label,
        labelStyle: labelStyle,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: fillColor), borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
