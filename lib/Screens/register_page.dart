import 'package:flutter/material.dart';
import 'package:sourcify/Models/user.dart';
import 'package:sourcify/Utilities/api/register_api.dart';
import 'package:sourcify/Utilities/routes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String name = "";
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  oveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      await Future.delayed(const Duration(milliseconds: 500));
      // ignore: use_build_context_synchronously
      await Navigator.pushNamed(context, RouteSet.homeRoute);
      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Image.asset("assets/images/hey.png", fit: BoxFit.cover),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Welcome $name",
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Name cannot be empty!!!";
                  } else if (value!.length < 3) {
                    return "Name must be atleast 3 characters long";
                  } else if (value.contains(RegExp(r'[0-9]'))) {
                    return "Name cannot contain numbers";
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  name = value;
                  setState(() {});
                },
              ),
              TextFormField(
                controller: _mobileController,
                decoration: const InputDecoration(labelText: 'Mobile'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Mobile cannot be empty!!!";
                  } else if (value!.length != 10) {
                    return "Mobile must be 10 digits long";
                  } else if (!value.contains(RegExp(r'[0-9]'))) {
                    return "Mobile cannot contain alphabets";
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Email cannot be empty!!!";
                  } else if (!value!.contains('@')) {
                    return "Email must contain @";
                  } else if (!value.contains('.')) {
                    return "Email must contain .";
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Password cannot be empty!!!";
                  } else if (value!.length < 6) {
                    return "Password length should be atleast 6!!!";
                  } else {
                    return null;
                  }
                },
                obscureText: true,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Call the API to register the user
                    Api().registerUser(User(
                      name: _nameController.text,
                      mobile: _mobileController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                    ));
                  }
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
