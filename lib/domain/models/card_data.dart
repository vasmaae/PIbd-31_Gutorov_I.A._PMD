import 'package:flutter/material.dart';

class BookData {
  final String title;
  final String author;
  final IconData icon;
  final String? imageUrl;
  final String? tip;

  BookData({
    required this.title,
    required this.author,
    this.icon = Icons.ac_unit_outlined,
    this.imageUrl,
    this.tip
  });
}
