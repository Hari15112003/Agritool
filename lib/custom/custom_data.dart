import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomSizeData {
  final double smalltext;
  final double largetext;
  final double mediumtext;
  final double iconSize;
  final double height;
  final double width;

  factory CustomSizeData.from({required BuildContext context}) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double aspectRatio = MediaQuery.of(context).size.aspectRatio;
    double mediumtext = aspectRatio * 34;
    double smalltext = aspectRatio * 27;
    double largetext = aspectRatio * 40;
    double iconSize = aspectRatio * 20;
    return CustomSizeData(
      smalltext: smalltext,
      largetext: largetext,
      mediumtext: mediumtext,
      height: height,
      width: width,
      iconSize: iconSize,
    );
  }

  CustomSizeData({
    required this.height,
    required this.width,
    required this.smalltext,
    required this.largetext,
    required this.mediumtext,
    required this.iconSize,
  });
}
