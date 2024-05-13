import 'package:agritool/custom/custom_data.dart';
import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final IconData icon;
  final double? size;
  final Color? color;

  const CustomIcon({
    super.key,
    required this.icon,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    CustomSizeData sizeData = CustomSizeData.from(context: context);
    double aspect = sizeData.aspectRatio;

    return Icon(
      icon,
      size: size ?? aspect * 55,
      color: color ?? Colors.black,
    );
  }
}
