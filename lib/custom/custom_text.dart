import 'package:agritool/custom/custom_data.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

  const CustomText({
    this.overflow,
    super.key,
    required this.text,
    this.textAlign,
    this.fontSize,
    this.fontWeight,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    CustomSizeData size = CustomSizeData.from(context: context);

    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        overflow: textAlign != null ? null : overflow ?? TextOverflow.ellipsis,
        fontSize: fontSize ?? size.mediumtext,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color,
      ),
    );
  }
}
