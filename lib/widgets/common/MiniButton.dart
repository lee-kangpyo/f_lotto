import 'package:flutter/material.dart';

class MiniButton extends StatelessWidget {
  const MiniButton({super.key, required this.btnText, this.onTap, this.width, this.height, this.fontSize = 13});
  final String btnText;
  final void Function()? onTap;
  final double? width;
  final double? height;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    Color? backColor = (onTap == null)?Color(0xffdddddd):null;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.grey,
          ),
          color: backColor,
        ),
        child: Center(
          child: Text(
            btnText,
            style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }
}
