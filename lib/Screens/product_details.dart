import 'package:flutter/material.dart';
import 'package:sourcify/Models/catalog.dart';
import 'package:sourcify/Widgets/home_widgets/addtocart.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductDetails extends StatelessWidget {
  final Item catalog;
  const ProductDetails({super.key, required this.catalog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.canvasColor,
        bottomNavigationBar: Container(
          color: context.cardColor,
          child: ButtonBar(
            buttonPadding: EdgeInsets.zero,
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              "\$${catalog.price}".text.bold.xl4.make(),
              AddToCart(catalog: catalog)
            ],
          ).p32(),
        ),
        appBar: AppBar(
          title: catalog.name.text.make(),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Hero(
                  tag: catalog.id.toString(),
                  child: Image.network(catalog.image).p16().h32(context)),
              Expanded(
                child: VxArc(
                    height: 30.0,
                    edge: VxEdge.top,
                    arcType: VxArcType.convey,
                    child: Container(
                      color: context.cardColor,
                      width: context.screenWidth,
                      child: Column(
                        children: [
                          catalog.name.text.xl4
                              .color(context.accentColor)
                              .bold
                              .make(),
                          catalog.desc.text.xl
                              .textStyle(context.captionStyle!)
                              .make(),
                          10.heightBox,
                          "Dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation"
                              .text
                              .textStyle(context.captionStyle!)
                              .make()
                              .p16()
                        ],
                      ).py64(),
                    )),
              ),
            ],
          ),
        ));
  }
}
