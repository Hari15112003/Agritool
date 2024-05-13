import 'package:agritool/custom/custom_text.dart';
import 'package:flutter/material.dart';

class RentalPage extends StatefulWidget {
  const RentalPage({super.key});

  @override
  State<RentalPage> createState() => _RentalPageState();
}

class _RentalPageState extends State<RentalPage> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomText(
          text: "rental Page",
        ),
      ],
    );
  }
}
