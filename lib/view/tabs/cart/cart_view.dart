import 'package:flutter/material.dart';
import 'package:shopelec/view/tabs/cart/components/item_cart.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 16,),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: const TextSpan(
                              children: [
                                TextSpan(
                                    text: "Deliver to",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300
                                    )
                                ),
                                TextSpan(
                                    text: " NguyenThang",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                    )
                                )
                              ]
                          )
                      ),
                      const SizedBox(height: 12,),
                      Text(
                        "Opposite Grand Mall, Ambavadi Road ,Elisbrigde Surenda "
                            "Mangaldas Rd, H Colony, Ambawadi, Ahmedabad, Gujarat"
                            " 380015",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey)
                    ),
                    child: const Center(child: Text("Change"))
                  )
                ),
                const SizedBox(width: 12,)
              ],
            ),
            const SizedBox(height: 8),
            Divider(
              color: Colors.grey[200],
              thickness: 1,
              height: 2,
            ),
            Container(
              height: 8,
              width: double.infinity,
              color: Colors.grey[200],
            ),
            Divider(
              color: Colors.grey[200],
              thickness: 1,
              height: 2,
            ),
            // const SizedBox(height: 12,),

            const ItemCart(
              imageUrl: "https://hanoicomputercdn.com/media/product/81430_laptop_lenovo_yoga_9_14imh9__83ac000svn_.jpg",
              title: "Apple MacBook Pro Core i9 9th Gen2",
              discount: 10,
              stock: 2,
              price: 2000,
            ),
            Divider(
              color: Colors.grey[200],
              thickness: 1,
              height: 2,
            ),
            const ItemCart(
              imageUrl: "https://hanoicomputercdn.com/media/product/81430_laptop_lenovo_yoga_9_14imh9__83ac000svn_.jpg",
              title: "Apple MacBook Pro Core i9 9th Gen2",
              discount: 10,
              stock: 2,
              price: 2000,
            ),
            Divider(
              color: Colors.grey[200],
              thickness: 1,
              height: 2,
            ),
            const ItemCart(
              imageUrl: "https://hanoicomputercdn.com/media/product/81430_laptop_lenovo_yoga_9_14imh9__83ac000svn_.jpg",
              title: "Apple MacBook Pro Core i9 9th Gen2",
              discount: 10,
              stock: 2,
              price: 2000,
            ),
            Divider(
              color: Colors.grey[200],
              thickness: 1,
              height: 2,
            ),
            Container(
              height: 8,
              width: double.infinity,
              color: Colors.grey[200],
            ),
            Divider(
              color: Colors.grey[200],
              thickness: 1,
              height: 2,
            ),

            Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 16.0,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12,),
                  Text(
                      "Bag total",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12,),

                  Row(
                    children: [
                      Text(
                          "Total MRP",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "\$22000.0",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    children: [
                      Text(
                        "Total Discount",
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "-" + "\$2200.0",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    children: [
                      Text(
                        "Selling Price",
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "\$20000.0",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    children: [
                      Text(
                        "Shipping Fee",
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "Free",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12,),
                  Divider(
                    color: Colors.grey[200],
                    thickness: 1,
                    height: 2,
                  ),
                  const SizedBox(height: 12,),

                  const Row(
                    children: [
                      Text(
                        "Amount Payable",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      Spacer(),
                      Text(
                        "\$20000.0",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: const Center(
                        child: Text(
                            "Checkout",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        )
                    ),
                  ),
                  const SizedBox(height: 16,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


