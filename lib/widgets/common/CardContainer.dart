import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({super.key, required this.child, this.backgroundColor, this.borderColor, this.borderWidth, this.onTap, this.margin = 8.0, this.padding=16.0});
  final Widget child;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final void Function()? onTap;
  final double margin;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(margin),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: SizedBox(
          child: Ink(
              decoration: BoxDecoration(
                color: backgroundColor ?? Colors.white,
                border: Border.all(
                  color: borderColor ?? const Color(0xff999999),
                  width: borderWidth ?? 1.0,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Center(child: child),
              )),
        ),
      ),
    );
  }
}
