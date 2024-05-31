import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopelec/model/cart.dart';

class ItemCart extends StatelessWidget {
  const ItemCart({super.key, required this.cart, this.onTap});

  final Cart cart;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    double priceDiscount = cart.price - cart.price * cart.discount / 100;
    double price = cart.price;
    int discount = cart.discount;
    int stock = cart.stock;
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 180,
            child: Center(
              child: Image.network(
                cart.imageUrl,
                fit: BoxFit.cover,
                height: 130,
                width: 140,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 14.0, left: 8.0, top: 16.0, bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cart.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\$$priceDiscount",
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "\$$price",
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          fontSize: 14,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Spacer(),
                      const Icon(
                        Icons.discount,
                        color: Colors.blue,
                        size: 24,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        "$discount%",
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Only $stock left",
                    style: const TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 35,
                    child: Row(
                      children: [
                        Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey)),
                          child: const Row(
                            children: [
                              SizedBox(
                                width: 4,
                              ),
                              SizedBox(
                                  width: 35,
                                  child: Icon(
                                    Iconsax.minus,
                                    color: Colors.grey,
                                    size: 20,
                                  )),
                              SizedBox(
                                width: 4,
                              ),
                              Text("1"),
                              SizedBox(
                                width: 4,
                              ),
                              SizedBox(
                                  width: 35,
                                  child: Icon(
                                    Iconsax.add,
                                    color: Colors.grey,
                                    size: 20,
                                  )),
                              SizedBox(
                                width: 4,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          height: double.infinity,
                          width: 35,
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey)),
                          child: const Icon(
                            Icons.favorite_border_outlined,
                            size: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          height: double.infinity,
                          width: 35,
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey)),
                          child: const Icon(
                            Icons.highlight_remove_sharp,
                            size: 18,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
