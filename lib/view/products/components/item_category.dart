import 'package:flutter/material.dart';
import 'package:shopelec/model/category.dart';

class ItemCategories extends StatefulWidget {
  const ItemCategories(
      {super.key, required this.category, this.onTap, this.color});

  final Category category;
  final void Function()? onTap;
  final Color? color;

  @override
  State<ItemCategories> createState() => _ItemCategoriesState();
}

class _ItemCategoriesState extends State<ItemCategories> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
          decoration: BoxDecoration(
              border:
                  Border.all(style: BorderStyle.solid, color: Colors.black54),
              borderRadius: BorderRadius.circular(8),
              color:
                  widget.color == Colors.black ? Colors.white : Colors.black),
          child: Center(
              child: Text(
            widget.category.name,
            style: TextStyle(
                fontSize: 16.0,
                color:
                    widget.color == Colors.black ? Colors.black : Colors.white),
          )),
        ));
  }
}
