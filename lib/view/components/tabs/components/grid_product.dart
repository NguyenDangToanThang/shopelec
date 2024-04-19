
import 'package:flutter/material.dart';
import 'package:shopelec/model/product.dart';

class GridProduct extends StatelessWidget {
  const GridProduct({super.key, required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: products.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          mainAxisExtent: 307,
        ),
        itemBuilder: (context,index) {
          Product product = products[index];
          return GestureDetector(
            onTap: () {

            },
            child: Container(
              height: 307,
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16,),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(120),
                          child: Image.network(
                            product.imageUrl,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          product.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 16,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            Text(
                              "Coupon 10%",
                              style: TextStyle(
                                  color: Colors.grey[600]
                              ),
                            ),
                            const Spacer(),
                            const Icon(Icons.star , color: Colors.amber, size: 18,),
                            const SizedBox(width: 4,),
                            Text(
                              '4.9',
                              style: TextStyle(color: Colors.grey[600]),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 16),
                        child: Text(
                          '\$2000',
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              decoration: TextDecoration.lineThrough
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          '\$1800',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Positioned(
                      top: 12,
                      right: 12,
                      child: Icon(Icons.favorite_border, color: Colors.grey,)
                  ),
                  const Align(
                      alignment: Alignment.bottomRight,
                      child: Material(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16)
                        ),
                        child: InkWell(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.add, color: Colors.grey,),
                          ),
                        ),
                      )
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}
