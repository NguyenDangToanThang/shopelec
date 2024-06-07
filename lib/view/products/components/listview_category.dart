
import 'package:flutter/material.dart';
import 'package:shopelec/model/category.dart';
import 'package:shopelec/view/products/components/item_category.dart';

class ListViewCategories extends StatefulWidget {
  const ListViewCategories({
    super.key,
    required this.categories,
  });

  final List<Category> categories;

  @override
  State<ListViewCategories> createState() => _ListViewCategoriesState();
}

class _ListViewCategoriesState extends State<ListViewCategories> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 40,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          Category category = widget.categories[index];
          return ItemCategories(
              category: category,
              color: (selectedIndex == index ? Colors.white : Colors.black),
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              });
        },
      ),
    );
  }
}
