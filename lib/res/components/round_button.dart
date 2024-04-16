import 'package:flutter/material.dart';
import 'package:shopelec/res/color.dart';

class RoundButton extends StatelessWidget {

  final String title;
  final bool loading;
  final VoidCallback onPress;

  const RoundButton({super.key ,
    required this.title,
    this.loading = false,
    required this.onPress
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 60,
        width: 295,
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
            child:loading ?
            CircularProgressIndicator(color: Colors.white) :
            Text(title, style: const TextStyle(color: AppColors.whiteColor),)
        ),
      ),
    );
  }
}
