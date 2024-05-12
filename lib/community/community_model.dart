import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommunityModel with ChangeNotifier {
  final String name;
  final String userId;
  final String? profileImage;
  final String heading;
  final String? subheading;
  final String content;
  final String date;
  final List<File>? imageUrl;
  final List<File>? videoUrl;
  CommunityModel({
    required this.userId,
    required this.date,
    required this.profileImage,
    required this.name,
    required this.content,
    required this.heading,
    this.subheading,
    this.imageUrl,
    this.videoUrl,
  });
}
