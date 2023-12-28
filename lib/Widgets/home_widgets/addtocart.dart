// ignore_for_file: no_leading_underscores_for_local_identifiers, library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sourcify/Models/cart_model.dart';
import 'package:sourcify/Models/catalog.dart';
import 'package:sourcify/Widgets/themes.dart';
import 'package:sourcify/core/store.dart';
import 'package:velocity_x/velocity_x.dart';

class AddToCart extends StatelessWidget {
  final Item catalog;
  const AddToCart({
    Key? key,
    required this.catalog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [AddMutation, RemoveMutation]);
    final CartModel _cart = (VxState.store as MyStore).cart;
    bool isInCart = _cart.items.contains(catalog);
    return ElevatedButton(
      onPressed: () {
        if (!isInCart) {
          AddMutation(catalog);
        }
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(MyTheme.darkBluishColor),
          shape: MaterialStateProperty.all(const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))))),
      child: isInCart
          ? const Icon(Icons.done,
              color: Colors.white, size: 20, semanticLabel: "Added to Cart")
          : const Icon(CupertinoIcons.cart_badge_plus,
              color: Colors.white, size: 20, semanticLabel: "Add to Cart"),
    );
  }
}
