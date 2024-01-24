import "package:flutter/material.dart";
import "package:sourcify/Models/user_cred.dart";
import 'package:sourcify/Utilities/api/api.dart';
import "package:sourcify/Utilities/routes.dart";

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String name = "";
  bool changeButton = false;
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  moveToHome(BuildContext context) async {
    if (_formkey.currentState!.validate()) {
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
      color: Colors.white,
      child: SingleChildScrollView(
          child: Form(
        key: _formkey,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Image.asset("assets/images/hey.png", fit: BoxFit.cover),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Welcome $name",
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        hintText: "Enter Email", labelText: "Email"),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Email cannot be empty!!!";
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
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        hintText: "Enter Password", labelText: "Password"),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Password cannot be empty!!!";
                      } else if (value!.length < 6) {
                        return "Password length should be atleast 6!!!";
                      } else {
                        return null;
                      }
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Material(
              borderRadius: BorderRadius.circular(changeButton ? 25 : 8),
              color: Colors.deepPurple,
              child: InkWell(
                onTap: () => {
                  Api()
                      .loginUser(UserCred(
                          email: _emailController.text,
                          password: _passwordController.text))
                      .then((res) => {
                            if (res.statusCode == 200)
                              {Navigator.pushNamed(context, RouteSet.homeRoute)}
                            else
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Invalid Credentials")))
                              }
                          })
                },
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: changeButton ? 50 : 150,
                    height: 50,
                    alignment: Alignment.center,
                    child: changeButton
                        ? const Icon(Icons.done, color: Colors.white)
                        : const Text("Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteSet.signupRoute);
              },
              child: const Text(
                "Don't have an account? Sign Up",
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            )
          ],
        ),
      )),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
