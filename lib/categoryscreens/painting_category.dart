import 'package:flutter/material.dart';
import 'package:ms_customer_app/utility/utilities.dart';
import 'package:ms_customer_app/widgets/category_widgets.dart';

class PaintingCategory extends StatelessWidget {
  const PaintingCategory({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _screensize = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          left: 0,
          bottom: 0,
          child: SizedBox(
            height: _screensize.height * 0.8,
            width: _screensize.width * 0.70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CategoryItemHeading(
                  subHeadings: 'Paintings',
                ),
                SizedBox(
                  height: _screensize.height * 0.68,
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 10.0,
                    children: List.generate(
                      paintings.length - 1,
                      (index) => CategoryImageView(
                        mainCategory: 'paintings',
                        subCategory: paintings[index + 1],
                        image: 'assets/images/image${index + 1}.jpg',
                        label: paintings[index + 1],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: _screensize.width * 0.08,
              height: _screensize.height * 0.75,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(25.0)),
              child: const CategorySlidebarText(
                subcategoryName: "Paintings",
              ),
            ),
          ),
        ),
      ],
    );
  }
}
