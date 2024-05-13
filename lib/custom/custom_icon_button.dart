import 'package:agritool/custom/custom_icon.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final String? tooltip;
  final VoidCallback onPressed;
  final CustomIcon icon;
  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      icon: icon,
    );
  }
}
