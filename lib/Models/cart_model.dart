import 'package:velocity_x/velocity_x.dart';

import 'package:sourcify/Models/catalog.dart';
import 'package:sourcify/core/store.dart';

class CartModel {
  // catalog field
  late CatalogModel _catalog;

  // Collection of IDs - store IDs of each item
  final List<String> _itemIds = [];

  // Get catalog
  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatalog) {
    // ignore: unnecessary_null_comparison
    assert(newCatalog != null);
    _catalog = newCatalog;
  }

  // Get items in the cart
  List<Item> get items => _itemIds.map((id) => _catalog.getById(id)).toList();

  // Get total price
  num get totalPrice =>
      items.fold(0, (total, current) => total + current.price);
}

class AddMutation extends VxMutation<MyStore> {
  final Item item;

  AddMutation(
    this.item,
  );

  @override
  perform() {
    store?.cart._itemIds.add(item.id);
  }
}

class RemoveMutation extends VxMutation<MyStore> {
  final Item item;

  RemoveMutation(
    this.item,
  );

  @override
  perform() {
    store?.cart._itemIds.remove(item.id);
  }
}
