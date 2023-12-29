import "package:flutter/material.dart";
import "package:sourcify/Screens/cart.dart";
import "package:sourcify/Screens/home.dart";
import "package:sourcify/Screens/login.dart";
import 'package:sourcify/Screens/register_page.dart';
import "package:sourcify/Utilities/routes.dart";
import "package:sourcify/Widgets/themes.dart";
import "package:sourcify/core/store.dart";
import "package:velocity_x/velocity_x.dart";

void main() {
  Vx.setPathUrlStrategy();
  runApp(VxState(store: MyStore(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sourcify",
      themeMode: ThemeMode.system,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      debugShowCheckedModeBanner: false,
      initialRoute: RouteSet.homeRoute,
      routes: {
        "/": (context) => const Login(),
        RouteSet.homeRoute: (context) => const Home(),
        RouteSet.loginRoute: (context) => const Login(),
        RouteSet.cartRoute: (context) => const Cart(),
        RouteSet.signupRoute: (context) => const RegisterPage(),
      },
    );
  }
}
