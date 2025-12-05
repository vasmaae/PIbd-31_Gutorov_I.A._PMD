import 'package:flutter/material.dart';

class CardData {
  final String title;
  final String authors;
  final IconData icon;
  final String? imageUrl;
  final String? rating;
  final int? id;

  CardData({
    required this.title,
    required this.authors,
    this.icon = Icons.ac_unit_outlined,
    this.imageUrl,
    this.rating,
    this.id,
  });
}
