import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/product.dart';
import 'package:shopelec/view/detail_product/components/RatingProgressIndicator.dart';
import 'package:shopelec/view/detail_product/components/rating_bar_star_indicator.dart';
import 'package:shopelec/view/review_product/components/user_review_card.dart';
import 'package:shopelec/view_model/product_view_model.dart';

class ProductReviewsScreen extends StatefulWidget {
  const ProductReviewsScreen({super.key, required this.product});

  final Product product;

  @override
  State<ProductReviewsScreen> createState() => _ProductReviewsScreenState();
}

class _ProductReviewsScreenState extends State<ProductReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đánh giá & xếp hạng'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Iconsax.notification))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Xếp hạng và đánh giá được xác minh và đến từ những '
                  'người sử dụng ứng dụng của chúng tôi'),
              const SizedBox(height: 8),
              //Remember extract to widget ok?
              Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            Text(
                              Provider.of<ProductViewModel>(context)
                                  .averageRating(widget.product)
                                  .toString(),
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            RatingBarStarIndicator(
                                rating: Provider.of<ProductViewModel>(context)
                                    .averageRating(widget.product)),
                            Text(
                              widget.product.reviews.length.toString(),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        RatingProgressIndicator(
                          text: '5',
                          value: Provider.of<ProductViewModel>(context)
                              .averageRatingWithStar(widget.product, 5),
                        ),
                        RatingProgressIndicator(
                          text: '4',
                          value: Provider.of<ProductViewModel>(context)
                              .averageRatingWithStar(widget.product, 4),
                        ),
                        RatingProgressIndicator(
                          text: '3',
                          value: Provider.of<ProductViewModel>(context)
                              .averageRatingWithStar(widget.product, 3),
                        ),
                        RatingProgressIndicator(
                          text: '2',
                          value: Provider.of<ProductViewModel>(context)
                              .averageRatingWithStar(widget.product, 2),
                        ),
                        RatingProgressIndicator(
                          text: '1',
                          value: Provider.of<ProductViewModel>(context)
                              .averageRatingWithStar(widget.product, 1),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),

              widget.product.reviews.isEmpty
                  ? const Center(
                      child: Text("Chưa có bình luận nào cho sản phẩm này"),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.product.reviews.length,
                      itemBuilder: (context, index) {
                        return UserReviewCard(
                            name: widget.product.reviews[index].name,
                            rating: widget.product.reviews[index].rate,
                            review: widget.product.reviews[index].comment,
                            date: widget.product.reviews[index].dateCreated);
                      })
            ],
          ),
        ),
      ),
    );
  }
}
