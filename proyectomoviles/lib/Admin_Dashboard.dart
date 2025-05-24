import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final _auth = FirebaseAuth.instance;
  String primerNombre = '';

  @override
  void initState() {
    super.initState();
    _cargarNombre();
  }

  Future<void> _cargarNombre() async {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      final doc = await FirebaseFirestore.instance.collection('usuarios').doc(uid).get();
      if (doc.exists) {
        final nombreCompleto = doc['nombre'] ?? 'Administrador';
        setState(() {
          primerNombre = nombreCompleto.split(' ').first;
        });
      }
    }
  }

  void _logout() async {
    await _auth.signOut();
    Navigator.of(context).pushReplacementNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    final altoPantalla = MediaQuery.of(context).size.height;
    final anchoPantalla = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Text(
              'Hola, $primerNombre',
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/admin.png',
              height: 160,
              width: 160,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: altoPantalla * 0.4,
              child: Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 30,
                  runSpacing: 30,
                  children: [
                    _botonAnimado(anchoPantalla, 'Usuarios', Icons.group, () {
                      Navigator.pushNamed(context, '/asignarRol');
                    }),
                    _botonAnimado(anchoPantalla, 'Mapa de Firmas', Icons.map, () {
                      Navigator.pushNamed(context, '/mapaFirmas');
                    }),
                    _botonAnimado(anchoPantalla, 'Notificaciones', Icons.notifications, () {
                      Navigator.pushNamed(context, '/notificaciones');
                    }),
                    _botonAnimado(anchoPantalla, 'Formatos', Icons.folder_open, () {
                      Navigator.pushNamed(context, '/formatos');
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'Formatos'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Mapa'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Salir'),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/adminHome');
              break;
            case 1:
              Navigator.pushNamed(context, '/formatos');
              break;
            case 2:
              Navigator.pushNamed(context, '/mapaFirmas');
              break;
            case 3:
              Navigator.pushNamed(context, '/perfil');
              break;
            case 4:
              _logout();
              break;
          }
        },
      ),
    );
  }

  Widget _botonAnimado(double anchoPantalla, String texto, IconData icono, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        width: (anchoPantalla - 90) / 2, // 2 botones por fila
        height: 130,
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(2, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icono, size: 36, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              texto,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
