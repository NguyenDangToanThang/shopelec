import 'package:flutter/material.dart';

class RatingProgressIndicator extends StatelessWidget {
  const RatingProgressIndicator({
    required this.text,
    required this.value,
    super.key,
  });

  final String text;
  final double value;

  Color ratingColor(double value) {
    if(value <= 0.2) {
      return (Colors.red);
    } else if(value <= 0.4) {
      return (Colors.yellow);
    } else if(value <= 0.6) {
      return (Colors.lightGreenAccent);
    } else if(value <= 0.8) {
      return (Colors.lightGreen);
    }
    return (Colors.green);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium,)
        ),
        Expanded(
          flex: 11,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: LinearProgressIndicator(
              value: value,
              minHeight: 11,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation(ratingColor(value)),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        )
      ],
    );
  }
}
