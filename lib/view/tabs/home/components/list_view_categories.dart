import 'package:flutter/material.dart';
import 'package:shopelec/utils/routes/routes_name.dart';
import 'package:shopelec/view/tabs/home/components/item_categories.dart';

class ListViewCategories extends StatelessWidget {
  const ListViewCategories({
    super.key,
    required this.categories,
    required this.height,
  });

  final List<Map<String, dynamic>> categories;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: categories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final category = categories[index];
            return ItemCategories(
              height: height,
              title: category['title'] as String,
              image: category['image'] as String,
              onTap: () {
                Navigator.pushNamed(context, RoutesName.productCategory,
                    arguments: category['title'] as String);
              },
            );
          }),
    );
  }
}
