import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SearchProduct extends StatelessWidget{
  const SearchProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      height: 50,
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        children: <Widget>[
          Expanded(
              child: TextField(
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Iconsax.search_favorite , color: Colors.grey,),
                    hintText: 'Tìm kiếm sản phẩm'
                ),
                onSubmitted: (String value) {

                },
              )
          ),
          Material(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                child: const Icon(Iconsax.search_favorite, color: Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }
}

