
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopelec/view/detail_product/components/RatingProgressIndicator.dart';
import 'package:shopelec/view/detail_product/components/rating_bar_star_indicator.dart';
import 'package:shopelec/view/review_product/components/user_review_card.dart';

class ProductReviewsScreen extends StatefulWidget {
  const ProductReviewsScreen({super.key});

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
          IconButton(
            onPressed: ()
            {},
            icon: const Icon(Iconsax.notification))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Xếp hạng và đánh giá được xác minh và đến từ những '
              'người sử dụng cùng loại thiết bị mà bạn sử dụng'),
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
                          Text('4.8' , style: Theme.of(context).textTheme.displayLarge,),
                          const RatingBarStarIndicator(rating: 4.5),
                          Text('12,644', style: Theme.of(context).textTheme.bodySmall,),
                        ],
                      ),
                    )
                  ),
                  const Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        RatingProgressIndicator(text: '5', value: 1.0,),
                        RatingProgressIndicator(text: '4', value: 0.8,),
                        RatingProgressIndicator(text: '3', value: 0.6,),
                        RatingProgressIndicator(text: '2', value: 0.4,),
                        RatingProgressIndicator(text: '1', value: 0.2,),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20,),
              const UserReviewCard(
                date: '16-11-2024',
                name: 'Charlie',
                rating: 4,
                review: 'The user interface of the app is quite intuitive. '
                  'I was able to navigate and make purchases seamlessly. Great Job!',),
              const UserReviewCard(
                date: '20-08-2024',
                name: 'John',
                rating: 1,
                review: 'The user interface of the app is quite intuitive. '
                    'I was able to navigate and make purchases seamlessly. Great Job!',
              ),
              const UserReviewCard(
                date: '01-02-2024',
                name: 'Emma',
                rating: 3.5,
                review: 'The user interface of the app is quite intuitive. '
                    'I was able to navigate and make purchases seamlessly. Great Job!',
              ),

            ],
          ),
        ),
      ),
    );
  }
}





