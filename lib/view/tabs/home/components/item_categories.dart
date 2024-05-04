import 'package:flutter/material.dart';

class ItemCategories extends StatelessWidget {
  const ItemCategories({
    super.key,
    required this.height,
    required this.image,
    required this.title,
    this.onTap
  });

  final double height;
  final String image;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(
                child: Image.asset(
                    image,
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: height * 0.005),
            Text(
              title,
              style: Theme.of(context).textTheme.labelMedium!
                  .apply(color: Colors.black),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
