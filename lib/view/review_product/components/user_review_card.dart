import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:shopelec/view/detail_product/components/rating_bar_star_indicator.dart';

class UserReviewCard extends StatefulWidget {
  const UserReviewCard({
    super.key,
    required this.name,
    required this.rating,
    required this.review,
    required this.date
  });

  final String name;
  final double rating;
  final String review;
  final String date;

  @override
  State<UserReviewCard> createState() => _UserReviewCardState();
}

class _UserReviewCardState extends State<UserReviewCard> {
  Offset? tapXY;
  // ↓ hold screen size, using first line in build() method
  RenderBox? overlay;
  @override
  Widget build(BuildContext context) {
    overlay = Overlay.of(context).context.findRenderObject() as RenderBox?;
    final myMenuItems = [
      const PopupMenuItem<int>(
        value: 1,
        child: Text('Report'),
      ),
    ];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(backgroundImage: AssetImage("assets/images/avatar.png")),
                const SizedBox(width: 4,),
                Text(widget.name, style: Theme.of(context).textTheme.titleMedium,)
              ],
            ),
            const Spacer(),
            const Icon(
                Iconsax.like_tag,
              size: 32,
            ),
            const Text(" 101"),
            InkWell(
              onTapDown: getPosition,
              child: IconButton(
                icon: const Icon(
                    Icons.more_vert),
                onPressed: () {
                  final popupMenu = PopupMenuButton(
                    onSelected: (item) {

                    },
                    itemBuilder: (context) => myMenuItems,
                  );
                  showMenu(
                      context: context,
                      position: relRectSize,
                      items: myMenuItems);
                },
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RatingBarStarIndicator(rating: widget.rating),
            const SizedBox(width: 8,),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text(widget.date, style: const TextStyle(fontSize: 12),),
            )
          ],
        ),

        const SizedBox(height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ReadMoreText(
                widget.review,
                trimLines: 1,
                trimMode: TrimMode.Line,
                trimExpandedText: ' less',
                trimCollapsedText: 'more',
                moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
                lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        )
      ],
    );
  }

  RelativeRect get relRectSize => RelativeRect.fromSize(tapXY! & const Size(40,40), overlay!.size);

  // ↓ get the tap position Offset
  void getPosition(TapDownDetails detail) {
    tapXY = detail.globalPosition;
  }
}