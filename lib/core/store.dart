import 'package:sourcify/Models/cart_model.dart';
import 'package:sourcify/Models/catalog.dart';
import 'package:velocity_x/velocity_x.dart';

class MyStore extends VxStore {
  CatalogModel catalog;
  CartModel cart;

  MyStore()
      : catalog = CatalogModel(),
        cart = CartModel() {
    catalog = CatalogModel();
    cart = CartModel();
    cart.catalog = catalog;
  }
}
