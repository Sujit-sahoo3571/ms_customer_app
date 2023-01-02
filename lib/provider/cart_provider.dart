import 'package:flutter/foundation.dart';
import 'package:ms_customer_app/provider/sqllitehelper.dart';
import 'product_class.dart';

class Cart extends ChangeNotifier {
  static List<Product> _list = [];
  List<Product> get getItems => _list;
  int? get count => _list.length;

  void addItems(Product product) async {
    await SQLHelper.insertItem(product).whenComplete(() => _list.add(product));

    notifyListeners();
  }

  void increment(Product product) async {
    await SQLHelper.updateItemqty(product, 1)
        .whenComplete(() => product.increase());
    notifyListeners();
  }

  void reduceByOne(Product product) async {
    await SQLHelper.updateItemqty(product, -1)
        .whenComplete(() => product.decrease());
    notifyListeners();
  }

  void removeItem(Product product) async {
    await SQLHelper.deleteItem(product.documentid)
        .whenComplete(() => _list.remove(product));

    notifyListeners();
  }

  void clearCart() async {
    await SQLHelper.deleteAllItem().whenComplete(() => _list.clear());

    notifyListeners();
  }

  double get totalPrice {
    double total = 0.0;
    for (var item in _list) {
      total += item.price * item.qty;
    }
    return total;
  }

  // load items
  loadItemsProvider() async {
    List<Map> data = await SQLHelper.loadCartItems();
    _list = data.map((product) {
      return Product(
        documentid: product["documentid"],
        name: product["name"],
        price: product["price"],
        qntty: product["qntty"],
        qty: product["qty"],
        imageUrl: product["imageUrl"],
        suppid: product["suppid"],
      );
    }).toList();

    notifyListeners();
  }
}
