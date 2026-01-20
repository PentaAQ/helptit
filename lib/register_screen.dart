import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Controladores
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _documentController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  // Variables de estado
  String _documentType = 'DNI';
  bool _acceptTerms = false;
  bool _hasScrolledToBottom = false;
  bool _showTermsModal = false;
  
  // Errores
  String? _nameError;
  String? _lastNameError;
  String? _documentError;
  String? _phoneError;
  String? _addressError;
  String? _emailError;
  String? _passwordError;
  
  bool get _isFormValid {
    return _nameController.text.isNotEmpty &&
           _lastNameController.text.isNotEmpty &&
           _documentController.text.isNotEmpty &&
           _documentController.text.length <= 10 &&
           _phoneController.text.isNotEmpty &&
           _phoneController.text.length >= 7 &&
           _addressController.text.isNotEmpty &&
           _emailController.text.isNotEmpty &&
           _emailController.text.contains('@') &&
           _passwordController.text.isNotEmpty &&
           _passwordController.text.length >= 6 &&
           _acceptTerms;
  }

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateName);
    _lastNameController.addListener(_validateLastName);
    _documentController.addListener(_validateDocument);
    _phoneController.addListener(_validatePhone);
    _addressController.addListener(_validateAddress);
    _emailController.addListener(_validateEmail);
    _passwordController.addListener(_validatePassword);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _documentController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateName() {
    setState(() {
      if (_nameController.text.isEmpty) {
        _nameError = null;
      } else if (_nameController.text.length < 2) {
        _nameError = 'El nombre debe tener al menos 2 caracteres';
      } else {
        _nameError = null;
      }
    });
  }

  void _validateLastName() {
    setState(() {
      if (_lastNameController.text.isEmpty) {
        _lastNameError = null;
      } else if (_lastNameController.text.length < 2) {
        _lastNameError = 'El apellido debe tener al menos 2 caracteres';
      } else {
        _lastNameError = null;
      }
    });
  }

  void _validateDocument() {
    setState(() {
      if (_documentController.text.isEmpty) {
        _documentError = null;
      } else if (_documentController.text.length > 10) {
        _documentError = 'El número no puede exceder 10 dígitos';
      } else if (_documentType == 'DNI' && _documentController.text.length != 8) {
        _documentError = 'El DNI debe tener 8 dígitos';
      } else {
        _documentError = null;
      }
    });
  }

  void _validatePhone() {
    setState(() {
      if (_phoneController.text.isEmpty) {
        _phoneError = null;
      } else if (_phoneController.text.length < 7) {
        _phoneError = 'El teléfono debe tener al menos 7 dígitos';
      } else if (_phoneController.text.length > 15) {
        _phoneError = 'El teléfono no puede exceder 15 dígitos';
      } else {
        _phoneError = null;
      }
    });
  }

  void _validateAddress() {
    setState(() {
      if (_addressController.text.isEmpty) {
        _addressError = null;
      } else if (_addressController.text.length < 5) {
        _addressError = 'La dirección debe tener al menos 5 caracteres';
      } else {
        _addressError = null;
      }
    });
  }

  void _validateEmail() {
    setState(() {
      if (_emailController.text.isEmpty) {
        _emailError = null;
      } else if (!_emailController.text.contains('@') || !_emailController.text.contains('.')) {
        _emailError = 'Ingrese un correo electrónico válido';
      } else {
        _emailError = null;
      }
    });
  }

  void _validatePassword() {
    setState(() {
      if (_passwordController.text.isEmpty) {
        _passwordError = null;
      } else if (_passwordController.text.length < 6) {
        _passwordError = 'La contraseña debe tener al menos 6 caracteres';
      } else {
        _passwordError = null;
      }
    });
  }

  void _register() {
    if (_isFormValid) {
      print('=== DATOS DE REGISTRO ===');
      print('Nombre: ${_nameController.text}');
      print('Apellido: ${_lastNameController.text}');
      print('Tipo Documento: $_documentType');
      print('Número Documento: ${_documentController.text}');
      print('Teléfono: ${_phoneController.text}');
      print('Dirección: ${_addressController.text}');
      print('Email: ${_emailController.text}');
      print('Contraseña: ${_passwordController.text}');
      print('Acepta términos: $_acceptTerms');
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cuenta creada exitosamente')),
      );
      Navigator.pushNamed(context, '/');
    }
  }

  void _showTermsAndConditions() {
    setState(() {
      _hasScrolledToBottom = false;
      _showTermsModal = true;
    });
  }

  void _acceptTermsFromModal() {
    setState(() {
      _acceptTerms = true;
      _showTermsModal = false;
    });
  }

  void _closeTermsModal() {
    setState(() {
      _showTermsModal = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Crear Cuenta'),
        centerTitle: true,
        backgroundColor: Colors.white,
        shape: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 1.0)),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Image.asset('assets/images/parcona_escudo.png', width: 80),
                //     SizedBox(width: 10),
                //     Image.asset('assets/images/parcona_palabra.png', width: 150),
                //   ],
                // ),
                // SizedBox(height: 20),
                // Center(
                //   child: Text(
                //     'Crear Cuenta',
                //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                //   ),
                // ),
                // SizedBox(height: 30),
                
                // Nombre
                Text('Nombre'),
                SizedBox(height: 5),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Ingresa tu nombre',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _nameError != null ? Colors.red : Colors.grey, 
                        width: 1.0
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _nameError != null ? Colors.red : Colors.blue, 
                        width: 2.0
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                if (_nameError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      _nameError!,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                SizedBox(height: 15),
                
                // Apellido
                Text('Apellido'),
                SizedBox(height: 5),
                TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    hintText: 'Ingresa tu apellido',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _lastNameError != null ? Colors.red : Colors.grey, 
                        width: 1.0
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _lastNameError != null ? Colors.red : Colors.blue, 
                        width: 2.0
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                if (_lastNameError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      _lastNameError!,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                SizedBox(height: 15),
                
                // Documento de identidad
                Text('Documento de Identidad'),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: DropdownButtonFormField<String>(
                        value: _documentType,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2.0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        items: ['DNI', 'C.E.'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _documentType = newValue!;
                            _validateDocument();
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: _documentController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Número de documento',
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
                    ),
                  ],
                ),
                if (_documentError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      _documentError!,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                SizedBox(height: 15),
                
                // Teléfono
                Text('Teléfono'),
                SizedBox(height: 5),
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Ingresa tu teléfono',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _phoneError != null ? Colors.red : Colors.grey, 
                        width: 1.0
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _phoneError != null ? Colors.red : Colors.blue, 
                        width: 2.0
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                if (_phoneError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      _phoneError!,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                SizedBox(height: 15),
                
                // Dirección
                Text('Dirección'),
                SizedBox(height: 5),
                TextField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    hintText: 'Ingresa tu dirección',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _addressError != null ? Colors.red : Colors.grey, 
                        width: 1.0
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _addressError != null ? Colors.red : Colors.blue, 
                        width: 2.0
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                if (_addressError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      _addressError!,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                SizedBox(height: 15),
                
                // Correo electrónico
                Text('Correo Electrónico'),
                SizedBox(height: 5),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Ingresa tu correo',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _emailError != null ? Colors.red : Colors.grey, 
                        width: 1.0
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: _emailError != null ? Colors.red : Colors.blue, 
                        width: 2.0
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                if (_emailError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      _emailError!,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                SizedBox(height: 15),
                
                // Contraseña
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
                SizedBox(height: 20),
                
                // Términos y condiciones
                Row(
                  children: [
                    Checkbox(
                      value: _acceptTerms,
                      onChanged: (bool? value) {
                        if (_acceptTerms) {
                          setState(() {
                            _acceptTerms = false;
                          });
                        } else {
                          _showTermsAndConditions();
                        }
                      },
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: _showTermsAndConditions,
                        child: Text(
                          'Acepto los términos y condiciones',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                
                // Botón de crear cuenta
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isFormValid ? _register : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isFormValid ? Colors.blueAccent : Colors.grey.shade300,
                      foregroundColor: Colors.white,
                      elevation: _isFormValid ? 2 : 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Crear Cuenta',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                
                // Texto de iniciar sesión
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '¿Ya tienes cuenta?',
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextButton(
                        child: Text(
                          ' Inicia Sesión',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          _buildTermsModal(),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 5,
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

  Widget _buildTermsModal() {
    return AnimatedOpacity(
      opacity: _showTermsModal ? 1.0 : 0.0,
      duration: Duration(milliseconds: 300),
      child: _showTermsModal
          ? Container(
              color: Colors.black54,
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Términos y Condiciones',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: _closeTermsModal,
                            icon: Icon(Icons.close),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Expanded(
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (scrollNotification) {
                            if (scrollNotification is ScrollEndNotification) {
                              if (scrollNotification.metrics.pixels >= 
                                  scrollNotification.metrics.maxScrollExtent - 50) {
                                setState(() {
                                  _hasScrolledToBottom = true;
                                });
                              }
                            }
                            return false;
                          },
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                '''
TÉRMINOS Y CONDICIONES DE USO

1. ACEPTACIÓN DE LOS TÉRMINOS
Bienvenido a nuestra aplicación. Al acceder y utilizar nuestros servicios, usted acepta y se compromete a cumplir con los siguientes términos y condiciones.

2. DESCRIPCIÓN DEL SERVICIO
Nuestra aplicación proporciona una plataforma para la gestión de servicios y comunicación entre usuarios. Nos reservamos el derecho de modificar, suspender o discontinuar cualquier aspecto del servicio en cualquier momento.

3. RESPONSABILIDADES DEL USUARIO
3.1. Proporcionar información veraz y actualizada al momento del registro.
3.2. Mantener la confidencialidad de sus credenciales de acceso.
3.3. Utilizar el servicio de manera responsable y conforme a la ley vigente.
3.4. No realizar actividades que puedan dañar o interrumpir el funcionamiento del sistema.

4. PROTECCIÓN DE DATOS PERSONALES
Nos comprometemos a proteger su información personal de acuerdo con las leyes de protección de datos aplicables. Sus datos serán utilizados únicamente para los fines descritos en nuestra política de privacidad.

5. PROPIEDAD INTELECTUAL
Todo el contenido de la aplicación, incluyendo texto, gráficos, logotipos, imágenes y software, es propiedad de nuestra empresa y está protegido por las leyes de propiedad intelectual.

6. LIMITACIÓN DE RESPONSABILIDAD
No nos hacemos responsables por daños directos, indirectos, incidentales o consecuentes que surjan del uso o la imposibilidad de uso de nuestro servicio.

7. MODIFICACIONES A LOS TÉRMINOS
Nos reservamos el derecho de modificar estos términos en cualquier momento. Las modificaciones entrarán en vigor desde su publicación en la aplicación.

8. LEY APLICABLE Y JURISDICCIÓN
Estos términos se rigen por las leyes del Perú. Cualquier controversia se resolverá mediante los tribunales competentes de Lima.

9. CONTACTO
Para cualquier pregunta sobre estos términos y condiciones, puede contactarnos a través de:
Email: soporte@parcona.com
Teléfono: (01) 234-5678

10. VIGENCIA
Estos términos y condiciones entran en vigor a partir del 1 de enero de 2024 y permanecerán vigentes hasta su modificación.

                                ''',
                                style: TextStyle(fontSize: 14, height: 1.5),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        child: _hasScrolledToBottom
                            ? SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: _acceptTermsFromModal,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'Aceptar Términos y Condiciones',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    'Por favor, desplácese hasta el final para aceptar',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Container(),
    );
  }
}
