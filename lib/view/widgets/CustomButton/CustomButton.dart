import 'package:flutter/material.dart';
import 'package:snap_n_go/core/constants/Constants.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Size? size;
  final VoidCallback? onTapCallBack;

  CustomButton({
    Key? key,
    required this.title,
    this.size,
    this.onTapCallBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapCallBack,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.orange.shade50,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: PRIMARY_COLOR,
              spreadRadius: 5,
              blurRadius: 12,
            ),
          ],
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
