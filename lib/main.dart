import "package:flutter/material.dart";
import "package:sourcify/Screens/cart.dart";
import "package:sourcify/Screens/home.dart";
import "package:sourcify/Screens/login.dart";
// import "package:sourcify/Screens/product_details.dart";
import 'package:sourcify/Screens/register_page.dart';
import "package:sourcify/Utilities/routes.dart";
import "package:sourcify/Widgets/themes.dart";
import "package:sourcify/core/store.dart";
import "package:url_strategy/url_strategy.dart";
import "package:velocity_x/velocity_x.dart";

void main() {
  setPathUrlStrategy();
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
      initialRoute: RouteSet.loginRoute,
      routes: {
        "/": (context) => const Login(),
        RouteSet.homeRoute: (context) => const Home(userLoggedIn: false),
        // RouteSet.productDetailsRoute: (context) => const ProductDetails(),
        RouteSet.loginRoute: (context) => const Login(),
        RouteSet.cartRoute: (context) => const Cart(),
        RouteSet.signupRoute: (context) => const RegisterPage(),
      },
    );
  }
}
