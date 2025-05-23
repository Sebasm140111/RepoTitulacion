import 'package:flutter/material.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _saveNewPassword() {
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos')),
      );
    } else if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Las contraseñas no coinciden')),
      );
    } else {
      // Aquí podrías enviar la nueva contraseña a una API
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Contraseña actualizada exitosamente')),
      );
    }
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
              // Parte superior con marco y llama
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
                        'Nueva Contraseña',
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

              // Nueva contraseña
              TextField(
                controller: _newPasswordController,
                obscureText: true,
                style: TextStyle(color: textoColor),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: rojo,
                  prefixIcon: Icon(Icons.lock, color: Colors.white),
                  labelText: 'Nueva Contraseña',
                  labelStyle: labelWithShadow,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: rojo),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Confirmar nueva contraseña
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

              // Botón guardar
              ElevatedButton(
                onPressed: _saveNewPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: fondoVino,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text('Guardar'),
              ),
              const SizedBox(height: 16),

              // Botón volver al inicio
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                },
                child: Text(
                  '← Volver al inicio',
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
