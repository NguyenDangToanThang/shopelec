
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopelec/model/product.dart';
import 'package:shopelec/utils/routes/routes_name.dart';

class GridProduct extends StatefulWidget {
  const GridProduct({super.key, required this.products});

  final List<Product> products;

  @override
  State<GridProduct> createState() => _GridProductState();
}

class _GridProductState extends State<GridProduct> {


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: widget.products.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          mainAxisExtent: 280,
        ),
        itemBuilder: (context,index) {
          Product product = widget.products[index];
          return Container(
            height: 280,
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10)
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
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RoutesName.detailProduct,arguments: product);

                        },
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
                    ),
                    const SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(4)
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(right: 5, left: 5),
                              child: Row(
                                children: [
                                  Icon(Icons.star , color: Colors.amber, size: 18,),
                                  SizedBox(width: 4,),
                                  Text(
                                    '4.9',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "99 left",
                            style: TextStyle(
                                color: Colors.grey[600]
                            ),
                          ),

                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 8),
                      child: Row(
                        children: [
                          Text(
                            '\$2000',
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                decoration: TextDecoration.lineThrough
                            ),
                          ),
                          const SizedBox(width: 10,),
                          const Icon(Icons.discount , color: Colors.blue, size: 16,),
                          Text(
                            '10%',
                            style: TextStyle(color: Colors.grey[600]),
                          )
                        ],
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
                Positioned(
                    top: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {

                        });
                      },
                      child: Row(
                        children: [
                          product.isFavorited ?
                          const Icon(Icons.favorite_border, color: Colors.grey,) :
                          const Icon(Icons.favorite, color: Colors.redAccent,)

                        ],
                      ),
                    )
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
          );
        }
    );
  }
}
