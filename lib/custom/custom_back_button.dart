import 'package:agritool/custom/custom_data.dart';
import 'package:agritool/custom/custom_text.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final String text;

  const CustomBackButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    CustomSizeData size = CustomSizeData.from(context: context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          BackButton(
            style: ButtonStyle(
              iconSize: MaterialStateProperty.all(size.iconSize),
            ),
          ),
          CustomText(
            text: text,
            fontSize: size.largetext,
          )
        ],
      ),
    );
  }
}
