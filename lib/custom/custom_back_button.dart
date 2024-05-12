import 'package:agritool/custom/custom_textfield.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final String text;
  final VoidCallback onpop;
  const CustomBackButton({
    super.key,
    required this.text,
    required this.onpop,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BackButton(),
        CustomText(text: text,)
      ],
    );
  }
}
