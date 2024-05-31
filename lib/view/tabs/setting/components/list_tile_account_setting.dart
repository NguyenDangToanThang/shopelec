import 'package:flutter/material.dart';

class ListTileAccountSetting extends StatelessWidget {
  const ListTileAccountSetting({
    super.key,
    required this.text,
    required this.subText,
    required this.iconsax,
    this.onTap
  });

  final String text;
  final String subText;
  final Icon iconsax;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8)
        ),
        child: ListTile(
          leading: iconsax,
          title: Text(
            text,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          subtitle: Text(
              subText,
              style: Theme.of(context).textTheme.bodySmall
          ),
        ),
      ),
    );
  }
}