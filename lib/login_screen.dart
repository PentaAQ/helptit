import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _documentController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  String? _documentError;
  String? _passwordError;
  
  bool get _isFormValid {
    return _documentController.text.length <= 10 && 
           _documentController.text.isNotEmpty &&
           _passwordController.text.length <= 8 && 
           _passwordController.text.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    _documentController.addListener(_validateDocument);
    _passwordController.addListener(_validatePassword);
  }

  @override
  void dispose() {
    _documentController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateDocument() {
    setState(() {
      if (_documentController.text.length > 10) {
        _documentError = 'El número de documento no puede exceder 10 dígitos';
      } else if (_documentController.text.isNotEmpty && _documentController.text.length < 8) {
        _documentError = 'El número de documento debe tener al menos 8 dígitos';
      } else {
        _documentError = null;
      }
    });
  }

  void _validatePassword() {
    setState(() {
      if (_passwordController.text.length > 8) {
        _passwordError = 'La contraseña no puede exceder 8 caracteres';
      } else if (_passwordController.text.isNotEmpty && _passwordController.text.length < 4) {
        _passwordError = 'La contraseña debe tener al menos 4 caracteres';
      } else {
        _passwordError = null;
      }
    });
  }

  void _login() {
    if (_isFormValid) {
      // print('Documento: ${_documentController.text}');
      // print('Contraseña: ${_passwordController.text}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Formulario enviado correctamente')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
        centerTitle: true,
        backgroundColor: Colors.white,
        shape: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 1.0)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 40, right: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/parcona_escudo.png',
                    width: 100,
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/images/parcona_palabra.png',
                    width: 200,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Bienvenido',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 40),
            Text('Num. Documento'),
            SizedBox(height: 5),
            TextField(
              controller: _documentController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Ingresa tu DNI',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _documentError != null ? Colors.red : Colors.grey, 
                    width: 1.0
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _documentError != null ? Colors.red : Colors.blue, 
                    width: 2.0
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            if (_documentError != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  _documentError!,
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            SizedBox(height: 20),
            Text('Contraseña'),
            SizedBox(height: 5),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: '••••••••',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _passwordError != null ? Colors.red : Colors.grey, 
                    width: 1.0
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _passwordError != null ? Colors.red : Colors.blue, 
                    width: 2.0
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            if (_passwordError != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  _passwordError!,
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '¿Olvidaste la contraseña?',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isFormValid ? _login : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isFormValid ? Colors.blueAccent : Colors.grey.shade300,
                  foregroundColor: Colors.white,
                  elevation: _isFormValid ? 2 : 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¿No tienes cuenta?',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    child: Text(
                      ' Regístrate',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 5, // Grosor de tu línea
        child: Row(
          children: [
            Expanded(child: Container(color: const Color(0xFFB1D148))),
            Expanded(child: Container(color: const Color(0xFFF4A817))),
            Expanded(child: Container(color: const Color(0xFFDE250E))),
            Expanded(child: Container(color: const Color(0xFF45B3F2))),
          ],
        ),
      ),
    );
  }
}
