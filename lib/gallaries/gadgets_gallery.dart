import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ms_customer_app/widgets/home_products_widgets.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class GadgetsGalleryScreen extends StatefulWidget {
  const GadgetsGalleryScreen({super.key});

  @override
  State<GadgetsGalleryScreen> createState() => _GadgetsGalleryScreenState();
}

class _GadgetsGalleryScreenState extends State<GadgetsGalleryScreen> {
  final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance
      .collection('products')
      .where('maincategory', isEqualTo: 'gadgets')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _productStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("something went wrong ");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "This category has no items for now.\nwe will update this soon!.",
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }

          return StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return ProductsModelHomeW(
                products: snapshot.data!.docs[index],
              );
            },
            staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
          );
        });
  }
}
