import 'package:agritool/custom/custom_data.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;

  const CustomText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    CustomSizeData size = CustomSizeData.from(context: context);

    return Text(
      text,
      style: TextStyle(
        overflow: TextOverflow.ellipsis,
        fontSize: fontSize ?? size.mediumtext,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontFamily: null,
        color: color,
      ),
    );
  }
}
