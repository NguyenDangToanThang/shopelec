import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/product.dart';
import 'package:shopelec/utils/routes/routes_name.dart';
import 'package:shopelec/utils/utils.dart';
import 'package:shopelec/view_model/product_view_model.dart';

class GridProduct extends StatefulWidget {
  const GridProduct({super.key, required this.products, required this.length});

  final List<Product> products;
  final int length;

  @override
  State<GridProduct> createState() => _GridProductState();
}

class _GridProductState extends State<GridProduct> {
  final logger = Logger();
  bool confirm = false;

  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context, listen: false);
    return GridView.builder(
        itemCount: widget.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          mainAxisExtent: 260,
        ),
        itemBuilder: (context, index) {
          Product product = widget.products[index];
          return GestureDetector(
            onTap: () async {
              final result = await Navigator.pushNamed(
                  context, RoutesName.detailProduct,
                  arguments: product);

              if (result != null && result is bool) {
                setState(() {
                  widget.products[index] =
                      widget.products[index].copyWith(favorite: result);
                });
              }
            },
            child: Container(
              height: 260,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
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
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          product.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 5, left: 5),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      Provider.of<ProductViewModel>(context,
                                              listen: false)
                                          .averageRating(product).toStringAsFixed(1),
                                      style:
                                          const TextStyle(color: Colors.white),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: Row(
                          children: [
                            Text(
                              NumberFormat.currency(
                                      locale: 'vi_VN', symbol: '₫')
                                  .format((product.price -
                                          product.price *
                                              product.discount /
                                              100)
                                      .toInt()),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
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
                                  '-${product.discount}%',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                      top: 8,
                      right: 6,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (product.favorite) {
                              _dialogBuilder(context, product, index);
                            } else {
                              product = product.copyWith(favorite: true);
                              productViewModel
                                  .saveFavorite(
                                      FirebaseAuth.instance.currentUser!.uid,
                                      product.id)
                                  .then((_) => Utils.flushBarSuccessMessage(
                                      "Đã thêm vào yêu thích", context));
                            }
                            widget.products[index] = product;
                          });
                        },
                        child: Row(
                          children: [
                            product.favorite
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.redAccent,
                                  )
                                : const Icon(
                                    Icons.favorite_border,
                                    color: Colors.grey,
                                  )
                          ],
                        ),
                      )),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _dialogBuilder(
      BuildContext context, Product product, int index) {
    final productViewModel =
        Provider.of<ProductViewModel>(context, listen: false);
    return showDialog<void>(
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
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Xác nhận'),
              onPressed: () {
                setState(() {
                  product = product.copyWith(favorite: false);
                  widget.products[index] = product;
                });
                productViewModel.deleteFavorite(
                    FirebaseAuth.instance.currentUser!.uid, product.id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
