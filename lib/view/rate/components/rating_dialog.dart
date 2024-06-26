import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shopelec/model/detail.dart';
import 'package:shopelec/view_model/rate_view_model.dart';

class RatingDialog extends StatefulWidget {
  const RatingDialog({super.key, required this.detail, required this.orderId});

  final Detail detail;
  final int orderId;

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  double _rating = 5.0;
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final rateViewModel = Provider.of<RateViewModel>(context, listen: false);
    return AlertDialog(
      title: const Text('Đánh giá sản phẩm'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            RatingBar.builder(
              initialRating: 5,
              minRating: 1,
              direction: Axis.horizontal,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _commentController,
              decoration: const InputDecoration(
                labelText: 'Bình luận',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: () {
            double rate = _rating;
            String comment = _commentController.text;
            Map data = {
              "rate": rate,
              "comment": comment,
              "productId": widget.detail.productId,
              "userId": FirebaseAuth.instance.currentUser!.uid,
              "orderId": widget.orderId
            };
            rateViewModel.saveRate(data);
            Navigator.of(context).pop(true);
          },
          child: const Text('Gửi'),
        ),
      ],
    );
  }
}
