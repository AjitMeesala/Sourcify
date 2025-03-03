// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:sourcify/Models/cart_model.dart";
import "package:sourcify/Utilities/routes.dart";
import 'package:sourcify/Widgets/home_widgets/catalog_header.dart';
import 'package:sourcify/Widgets/home_widgets/catalog_list.dart';
import "package:sourcify/core/store.dart";
import "package:velocity_x/velocity_x.dart";
import "package:sourcify/Models/catalog.dart";
import "package:sourcify/Widgets/themes.dart";
import "package:http/http.dart" as http;

class Home extends StatefulWidget {
  final bool userLoggedIn; // Add a parameter to receive the value of userLoggedIn

  const Home({Key? key, required this.userLoggedIn}) : super(key: key);

  @override
  State<Home> createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  final url = "https://Sourcify.onrender.com/api/get/products";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    final res = await http.get(Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
        });
    final catalogJson = res.body;
    final decodedData = jsonDecode(catalogJson);
    var productsData = decodedData["products"];
    CatalogModel.items = List.from(productsData)
        .map<Item>((item) => Item.fromMap(item))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _cart = (VxState.store as MyStore).cart;
    return Scaffold(
        backgroundColor: context.canvasColor,
        floatingActionButton: widget.userLoggedIn // Show the floating action button only if user is logged in
            ? VxBuilder(
                mutations: const {AddMutation, RemoveMutation},
                builder: (context, store, status) => FloatingActionButton(
                  shape: const StadiumBorder(),
                  backgroundColor: MyTheme.darkBluishColor,
                  onPressed: () => {Navigator.pushNamed(context, RouteSet.cartRoute)},
                  child:
                const Icon(CupertinoIcons.cart, color: Colors.white, size: 25),
                ).badge(
                  color: Vx.green500,
                  size: 20,
                  count: _cart.items.length,
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              )
            : FloatingActionButton(
                shape: const StadiumBorder(),
                backgroundColor: MyTheme.darkBluishColor,
                onPressed: () => {Navigator.pushNamed(context, RouteSet.loginRoute)},
                child: const Icon(CupertinoIcons.person, color: Colors.white, size: 25),
              ), // Show the login floating action button if user is not logged in
        body: SafeArea(
            // ignore: avoid_unnecessary_containers
            child: Container(
                padding: Vx.mOnly(top: 32, right: 16, left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CatalogHeader(),
                    if (CatalogModel.items.isNotEmpty)
                      const CatalogList().pOnly(top: 16).expand()
                    else
                      const CircularProgressIndicator()
                          .centered()
                          .expand()
                  ],
                ))));
  }
}
