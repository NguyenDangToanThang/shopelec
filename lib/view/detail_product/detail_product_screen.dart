import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/product.dart';
import 'package:shopelec/utils/routes/routes_name.dart';
import 'package:shopelec/view/tabs/home/components/bottom_add_to_cart.dart';
import 'package:shopelec/view_model/product_view_model.dart';

class DetailProductScreen extends StatefulWidget {
  const DetailProductScreen({super.key, required this.product});
  final Product product;

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  bool favorite = false;
  late Product product;

  @override
  void initState() {
    super.initState();
    favorite = widget.product.favorite;
    product = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);
    return Scaffold(
      bottomNavigationBar: BottomAddToCart(product: widget.product),
      appBar: AppBar(
        title: const Text("Chi tiết sản phẩm"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, product.favorite);
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.cart);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              right: 12.0, left: 12.0, top: 4.0, bottom: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                widget.product.image_url,
                fit: BoxFit.contain,
                height: 230,
                width: double.infinity,
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding:
                              const EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 2.0),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min, // Constrain width
                            children: [
                              const SizedBox(width: 2.0),
                              const Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 16.0, // Adjust icon size as needed
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                Provider.of<ProductViewModel>(context,
                                        listen: false)
                                    .averageRating(widget.product)
                                    .toStringAsFixed(1),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0, // Adjust font size as needed
                                ),
                              ),
                              const SizedBox(width: 2.0),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          '(${widget.product.reviews.length} đánh giá)',
                          style: const TextStyle(
                            fontSize: 12.0, // Adjust font size as needed
                            color: Colors.grey,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Còn ${widget.product.quantity}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                              .format((widget.product.price -
                                      widget.product.price *
                                          widget.product.discount /
                                          100)
                                  .toInt()),
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                              .format((widget.product.price).toInt()),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Spacer(),

                        Container(
                          width: 42,
                          height: 20,
                          decoration: BoxDecoration(
                              color: Colors.red[100],
                              borderRadius: BorderRadius.circular(4)),
                          child: Center(
                            child: Text(
                              '-${widget.product.discount}%',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () async {
                        //     if (product.favorite) {
                        //       _dialogBuilder(context).then((value) {
                        //         if (value!) {
                        //           setState(() {
                        //             product = product.copyWith(
                        //                 favorite: !product.favorite);
                        //           });
                        //         }
                        //       });
                        //     } else {
                        //       productViewModel.saveFavorite(
                        //           FirebaseAuth.instance.currentUser!.uid,
                        //           widget.product.id);
                        //       setState(() {
                        //         product = product.copyWith(
                        //             favorite: !product.favorite);
                        //       });
                        //       Utils.flushBarSuccessMessage(
                        //           "Đã thêm vào yêu thích", context);
                        //     }
                        //   },
                        //   child: Container(
                        //     padding: const EdgeInsets.all(4),
                        //     decoration: BoxDecoration(
                        //         color: Colors.grey[200],
                        //         borderRadius: BorderRadius.circular(30)),
                        //     child: product.favorite
                        //         ? const Icon(
                        //             Icons.favorite_outlined,
                        //             color: Colors.redAccent,
                        //           )
                        //         : const Icon(
                        //             Icons.favorite_border,
                        //             color: Colors.black,
                        //           ),
                        //   ),
                        // )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Divider(
                color: Colors.black54,
                thickness: 0.5,
                height: 5,
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Mô tả sản phẩm',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.product.description,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Divider(
                color: Colors.black54,
                thickness: 0.5,
                height: 5,
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Thông số kỹ thuật',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.product.specifications.length,
                      itemBuilder: (context, index) {
                        final specification =
                            widget.product.specifications[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Text(
                            "${specification.name} :  ${specification.description}",
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Divider(
                color: Colors.black54,
                thickness: 0.5,
                height: 5,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.productReviews,
                      arguments: widget.product);
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Đánh giá (${widget.product.reviews.length} đánh giá)",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.keyboard_arrow_right_outlined),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RoutesName.productReviews,
                              arguments: widget.product);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> _dialogBuilder(BuildContext context) {
    final productViewModel =
        Provider.of<ProductViewModel>(context, listen: false);
    return showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận'),
          content: const Text('Xóa sản phẩm khỏi mục yêu thích ?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Xác nhận'),
              onPressed: () {
                productViewModel.deleteFavorite(
                    FirebaseAuth.instance.currentUser!.uid, widget.product.id);
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
