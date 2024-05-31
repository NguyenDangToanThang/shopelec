

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:shopelec/model/product.dart';
import 'package:shopelec/utils/routes/routes_name.dart';
import 'package:shopelec/view/tabs/home/components/bottom_add_to_cart.dart';

class DetailProductScreen extends StatefulWidget {
  const DetailProductScreen({super.key, required this.product});
  final Product product;

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}
List<Map<String, String>> fakeSpecifications = [
  {'title': 'Monitor', 'value': '15.6" FHD (1920x1080) 144Hz'},
  {'title': 'CPU', 'value': 'Intel Core i7-11700H (2.50 GHz upto 4.90 GHz, 12MB)'},
  {'title': 'RAM', 'value': '16GB (2x 8GB) DDR4-3200MHz (2 slots) (Max 32GB)'},
  {'title': 'Hard drive', 'value': '512GB SSD M.2 2280 PCIe 3.0x4 NVMe (1 slot available)'},
  {'title': 'VGA', 'value': 'NVIDIA GeForce RTX 3060 6GB GDDR6'},
];

class _DetailProductScreenState extends State<DetailProductScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomAddToCart(),
      appBar: AppBar(
        title: const Text("Details Product"),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Iconsax.notification) , onPressed: (){},)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 12.0 , left: 12.0 , top: 4.0 , bottom: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                widget.product.image_url,
                fit: BoxFit.cover,
                height: 230,
                width: double.infinity,
              ),
              const SizedBox(height: 12),
              const Text(
                  'Apple MacBook Pro Core i9 9th Gen',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  ),
                ),
              const SizedBox(height: 4,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('99' ' remaining' ,
                    style: TextStyle(
                      fontSize: 16
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    '(90 Ratings)',
                    style: TextStyle(
                      fontSize: 12.0, // Adjust font size as needed
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Container(
                    padding: const EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 2.0),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min, // Constrain width
                      children: [
                        Text(
                          '4.9',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0, // Adjust font size as needed
                          ),
                        ),
                        SizedBox(width: 4.0),
                        Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 16.0, // Adjust icon size as needed
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '\$${widget.product.price}',
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 8,),
                  Text(
                    '\$${widget.product.price * widget.product.discount / 100}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8,),
                  const Icon(Icons.discount , color: Colors.blue, size: 22,),
                  Text(
                    '${widget.product.discount}%',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: const Icon(Icons.favorite_border, color: Colors.black,),
                  )

                ],
              ),
              const SizedBox(height: 12,),
              const Divider(
                color: Colors.black54,
                thickness: 0.5,
                height: 5,
              ),
              const SizedBox(height: 12,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 10,),
                  ReadMoreText(widget.product.description,
                      trimLines: 3,
                      trimMode: TrimMode.Line,
                      trimExpandedText: ' Less',
                      trimCollapsedText: 'More',
                      moreStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
                      lessStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 16
                      ),
                  )
                ],
              ),
              const SizedBox(height: 12,),

              const Divider(
                color: Colors.black54,
                thickness: 0.5,
                height: 5,
              ),
              const SizedBox(height: 12,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Specifications',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 8,),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: fakeSpecifications.length,
                    itemBuilder: (context, index) {
                      final specification = fakeSpecifications[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Text(
                          "${specification['title']!} ${specification['value']!}",
                          style: const TextStyle(
                            fontSize: 16
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
              const SizedBox(height: 12,),
              const Divider(
                color: Colors.black54,
                thickness: 0.5,
                height: 5,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.productReviews);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "Product Reviews (99 reviews)" ,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.keyboard_arrow_right_outlined),
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesName.productReviews);
                      },
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
