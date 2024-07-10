import 'package:flutter/material.dart';
import 'package:shopelec/view/detail_product/components/rating_bar_star_indicator.dart';

class UserReviewCard extends StatefulWidget {
  const UserReviewCard(
      {super.key,
      required this.name,
      required this.rating,
      required this.review,
      required this.date,
      required this.image});

  final String name;
  final double rating;
  final String review;
  final String date;
  final String image;

  @override
  State<UserReviewCard> createState() => _UserReviewCardState();
}

class _UserReviewCardState extends State<UserReviewCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                      // backgroundImage: NetworkImage("")
                      backgroundImage: widget.image == ""
                          ? const AssetImage("assets/images/avatar.png")
                          : NetworkImage(widget.image) as ImageProvider),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    widget.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text("-", style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      widget.date,
                      style: const TextStyle(fontSize: 14),
                    ),
                  )
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RatingBarStarIndicator(rating: widget.rating),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                widget.review,
                textAlign: TextAlign.left,
              )),
            ],
          )
        ],
      ),
    );
  }
}
