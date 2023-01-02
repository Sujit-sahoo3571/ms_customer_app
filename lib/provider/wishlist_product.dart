import 'package:flutter/foundation.dart';
import 'package:ms_customer_app/provider/sqllitehelper.dart';
import 'product_class.dart';

class Wish extends ChangeNotifier {
  static List<Product> _list = [];
  List<Product> get getwishItems => _list;
  int? get count => _list.length;

  void addWishItems(Product product) async {
    await SQLHelper.insertWishList(product)
        .whenComplete(() => _list.add(product));
    notifyListeners();
  }

  void removeItem(Product product) async {
    await SQLHelper.removeWishListItem(product)
        .whenComplete(() => _list.remove(product));
    notifyListeners();
  }

  void clearWishList() async {
    await SQLHelper.removeAllWishList().whenComplete(() => _list.clear());

    notifyListeners();
  }

  void removeThis(String id) {
    _list.removeWhere((element) => element.documentid == id);
    notifyListeners();
  }

  //load data
  void loadWishlist() async {
    List<Map> data = await SQLHelper.loadWishList();
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
