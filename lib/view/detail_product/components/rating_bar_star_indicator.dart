
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';

class RatingBarStarIndicator extends StatelessWidget {
  const RatingBarStarIndicator({
    super.key,
    required this.rating
  });
  final double rating;
  Color ratingColor(double value) {
    if(value <= 1) {
      return (Colors.red);

    } else if(value <= 2) {
      return (Colors.yellow);
    } else if(value <= 3) {
      return (Colors.lightGreenAccent);
    } else if(value <= 4) {
      return (Colors.lightGreen);
    }
    return (Colors.green);
  }

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
        rating: rating,
        itemSize: 18,
        unratedColor: Colors.grey[400],
        itemBuilder: (_,__) => Icon(Iconsax.star1, color: ratingColor(rating),)
    );
  }
}