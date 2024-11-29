import 'package:flutter/material.dart';

class Sep extends StatelessWidget {
  const Sep({super.key, this.height, this.width});
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, width: width,);
  }
}
