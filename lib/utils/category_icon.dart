import 'package:flutter/material.dart';

abstract class CategoryIcon {
  static IconData getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'salary':
        return Icons.monetization_on;
      case 'freelance':
        return Icons.work;
      case 'bonus':
        return Icons.card_giftcard;
      case 'food':
        return Icons.fastfood;
      case 'fuel':
        return Icons.local_gas_station;
      case 'shopping':
        return Icons.shopping_bag;
      case 'bills':
        return Icons.receipt_long;
      case 'entertainment':
        return Icons.movie;
      case 'travel':
        return Icons.flight;
      case 'medical':
        return Icons.medical_services;
      default:
        return Icons.category;
    }
  }
}