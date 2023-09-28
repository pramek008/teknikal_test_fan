import 'package:flutter/material.dart';
import 'package:test_teknikal_fan/utils/theme.dart';

class CustomButtonWidget extends StatelessWidget {
  final String btnName;
  final Color? btnColor;
  final double width;
  final bool statusColor;
  final Function() onPressed;
  const CustomButtonWidget(
      {super.key,
      required this.btnName,
      this.btnColor,
      required this.width,
      required this.statusColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - width,
      decoration: BoxDecoration(
        color: statusColor ? blackColor : whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: statusColor ? Colors.transparent : blackColor,
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          btnName,
          style: txSemiBold.copyWith(
            fontSize: 15,
            color: statusColor ? whiteColor : blackColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
