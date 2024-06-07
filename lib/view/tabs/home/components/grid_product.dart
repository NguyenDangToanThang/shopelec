import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/product.dart';
import 'package:shopelec/utils/routes/routes_name.dart';
import 'package:shopelec/view_model/auth_view_model.dart';
import 'package:shopelec/view_model/cart_view_model.dart';

class GridProduct extends StatefulWidget {
  const GridProduct({super.key, required this.products, required this.length});

  final List<Product> products;
  final int length;

  @override
  State<GridProduct> createState() => _GridProductState();
}

class _GridProductState extends State<GridProduct> {
  final logger = Logger();

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);
    return GridView.builder(
        itemCount: widget.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          mainAxisExtent: 280,
        ),
        itemBuilder: (context, index) {
          Product product = widget.products[index];
          return Container(
            height: 280,
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10)),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          product.image_url,
                          width: 100,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RoutesName.detailProduct,
                              arguments: product);
                        },
                        child: Text(
                          product.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(4)),
                            child: const Padding(
                              padding: EdgeInsets.only(right: 5, left: 5),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
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
                            "Còn ${product.quantity}",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 8),
                      child: Row(
                        children: [
                          Text(
                            '\$${product.price}',
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.discount,
                            color: Colors.blue,
                            size: 16,
                          ),
                          Text(
                            '${product.discount}%',
                            style: TextStyle(color: Colors.grey[600]),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        '${product.price - product.price * product.discount / 100}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                    top: 8,
                    right: 6,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {});
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.favorite_border,
                            color: Colors.grey,
                          )
                          // product.isFavorited
                          //     ? const Icon(
                          //         Icons.favorite_border,
                          //         color: Colors.grey,
                          //       )
                          //     : const Icon(
                          //         Icons.favorite,
                          //         color: Colors.redAccent,
                          //       )
                        ],
                      ),
                    )),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Material(
                      color: Colors.black,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16)),
                      child: InkWell(
                        onTap: () {
                          // Cart cart = Cart(
                          //     email: authViewModel.infoUserCurrent['email'],
                          //     product: product,
                          //     quantity: 1);
                          Map<String, dynamic> cart = {
                            'email': authViewModel.infoUserCurrent['email'],
                            'product_id': product.id.toString(),
                            'quantity': '1'
                          };
                          logger.i(cart);
                          cartViewModel.addToCart(cart, context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.add,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          );
        });
  }
}
