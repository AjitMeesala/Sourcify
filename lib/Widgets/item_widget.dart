import 'package:flutter/material.dart';
import 'package:sourcify/Models/catalog.dart';

class ItemWidget extends StatelessWidget {
  final Item item;
  const ItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
        surfaceTintColor: Colors.white,
        child: ListTile(
          leading: Image(image: NetworkImage(item.image)),
          title: Text(item.name),
          subtitle: Text(item.desc),
          trailing: Text(
            "\$${item.price.toString()}",
            // ignore: deprecated_member_use
            textScaleFactor: 1.5,
            style: const TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }
}
