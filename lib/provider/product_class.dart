class Product {
  String documentid;
  String name;
  double price;
  int qty = 1;
  int qntty;
  // List imageUrl;
  String imageUrl;
  String suppid;

  Product({
    required this.documentid,
    required this.name,
    required this.price,
    required this.qntty,
    required this.qty,
    required this.imageUrl,
    required this.suppid,
  });

  void increase() {
    qty++;
  }

  void decrease() {
    qty--;
  }

  //convert to Map {key: value }

  Map<String, dynamic> toMap() {
    return {
      "documentid": documentid,
      "name": name,
      "price": price,
      "qty": qty,
      "qntty": qntty,
      "imageurl": imageUrl,
      "suppid": suppid,
    };
  }

  //string
  @override
  String toString() {
    return "Product{name: $name, price: $price, qty:$qty, qntty: $qntty, imageurl: $imageUrl, suppid: $suppid   }";
  }
}
