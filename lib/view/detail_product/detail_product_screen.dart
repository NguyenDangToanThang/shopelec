import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:shopelec/model/product.dart';
import 'package:shopelec/utils/routes/routes_name.dart';
import 'package:shopelec/utils/utils.dart';
import 'package:shopelec/view/tabs/home/components/bottom_add_to_cart.dart';
import 'package:shopelec/view_model/auth_view_model.dart';
import 'package:shopelec/view_model/product_view_model.dart';

class DetailProductScreen extends StatefulWidget {
  const DetailProductScreen({super.key, required this.product});
  final Product product;

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);
    bool favorite = widget.product.favorite;
    return Scaffold(
      bottomNavigationBar: BottomAddToCart(product: widget.product),
      appBar: AppBar(
        title: const Text("Chi tiết sản phẩm"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.notification),
            onPressed: () {},
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
              const Text(
                'Apple MacBook Pro Core i9 9th Gen',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Còn ${widget.product.quantity}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  const Text(
                    '(90 đánh giá)',
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
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    '\$${widget.product.price - widget.product.price * widget.product.discount / 100}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Icon(
                    Icons.discount,
                    color: Colors.blue,
                    size: 22,
                  ),
                  Text(
                    '${widget.product.discount}%',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () { 
                      setState(() {
                        if (favorite) {
                        _dialogBuilder(context);
                      } else {
                        productViewModel
                            .saveFavorite(authViewModel.infoUserCurrent['id'],
                                widget.product.id)
                            .then((_) => Utils.flushBarSuccessMessage("Đã thêm vào yêu thích", context));
                      }
                        favorite = !favorite;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(30)),
                      child: favorite
                          ? const Icon(
                              Icons.favorite_outlined,
                              color: Colors.redAccent,
                            )
                          : const Icon(
                              Icons.favorite_border,
                              color: Colors.black,
                            ),
                    ),
                  )
                ],
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Mô tả sản phẩm',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ReadMoreText(
                    widget.product.description,
                    trimLines: 3,
                    trimMode: TrimMode.Line,
                    trimExpandedText: ' Rút gọn',
                    trimCollapsedText: 'Xem thêm',
                    moreStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                    lessStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 16),
                  )
                ],
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Thông số kỹ thuật',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
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
                          style: const TextStyle(fontSize: 16),
                        ),
                      );
                    },
                  )
                ],
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
                  Navigator.pushNamed(context, RoutesName.productReviews);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Product Reviews (99 reviews)",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
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

  Future<void> _dialogBuilder(BuildContext context) {
    final productViewModel =
        Provider.of<ProductViewModel>(context, listen: false);
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
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
                productViewModel.deleteFavorite(
                    authViewModel.infoUserCurrent['id'], widget.product.id);
                // print(authViewModel.infoUserCurrent['id']);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
