import 'package:flutter/material.dart';
import '../widgets/button.dart';
import '../widgets/input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: Scaffold(
            body: Row(
      children: [SignUpForm()],
    )));
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'REGÍSTRATE',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          Input(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese un nombre de usuario';
                }
                return null;
              },
              controller: _usernameController,
              hintText: 'Ingrese el nombre de usuario',
              labelText: 'Nombre de usuario'),
          Input(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese su nombre completo';
                }
                return null;
              },
              controller: _nameController,
              hintText: 'Ingrese su nombre completo',
              labelText: 'Nombre completo'),
          Input(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese su email';
                } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Ingrese un email válido';
                }
                return null;
              },
              controller: _emailController,
              hintText: 'ejemplo@gmail.com',
              labelText: 'Correo electrónico'),
          Input(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese una contraseña';
                } else if (value != _repeatPasswordController.text) {
                  return 'Las contraseñas deben ser iguales';
                }
                return null;
              },
              controller: _passwordController,
              hintText: 'Ingrese su contraseña',
              labelText: 'Contraseña'),
          Input(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Repita su contraseña';
                } else if (value != _passwordController.text) {
                  return 'Las contraseñas deben ser iguales';
                }
                return null;
              },
              controller: _repeatPasswordController,
              hintText: 'Vuelva a ingresar su contraseña',
              labelText: 'Confirmar contraseña'),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Button(
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  final user = <String, dynamic>{
                    'username': _usernameController.text,
                    'name': _nameController.text,
                    'email': _emailController.text,
                    'password': _passwordController.text,
                    'role': 'usuario'
                  };

                  db.collection('usuarios').add(user).then(
                      (DocumentReference doc) =>
                          print('document snapshot added'));
                  Navigator.pop(context);
                }
              },
              text: 'Crear Cuenta',
            ),
          ),
        ],
      ),
    );
  }
}
