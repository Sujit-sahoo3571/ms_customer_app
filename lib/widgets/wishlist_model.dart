import 'package:flutter/material.dart';
import 'package:ms_customer_app/provider/cart_provider.dart';
import 'package:ms_customer_app/provider/product_class.dart';
import 'package:ms_customer_app/provider/wishlist_product.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class wishListModel extends StatelessWidget {
  const wishListModel({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: SizedBox(
          height: 120.0,
          child: Row(
            children: [
              SizedBox(
                height: 100.0,
                width: 120.0,
                child: Image.network(product.imageUrl),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                            fontSize: 16.0),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rs. ${product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                                color: Colors.red,
                                fontFamily: "Poppins",
                                fontSize: 16.0),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text("Delete"),
                                      content:
                                          const Text("Sure to delete this? "),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              context
                                                  .read<Wish>()
                                                  .removeItem(product);
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Yes")),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("No"))
                                      ],
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.delete_forever),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              context.watch<Cart>().getItems.firstWhereOrNull(
                                              (element) =>
                                                  element.documentid ==
                                                  product.documentid) !=
                                          null ||
                                      product.qntty == 0
                                  ? const SizedBox()
                                  : IconButton(
                                      onPressed: () {
                                        context.read<Cart>().addItems(Product(
                                                documentid: product.documentid,
                                                name: product.name,
                                                price: product.price,
                                                qntty: product.qntty,
                                                qty: 1,
                                                imageUrl: product.imageUrl,
                                                suppid: product.suppid)
                                          
                                            );
                                      },
                                      icon:
                                          const Icon(Icons.add_shopping_cart)),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
