import 'package:flutter/material.dart';

class OrderItem {
  final String id;
  final String cardTitle;
  final String cardSubtitle;
  final int usdValue;
  final int paidAmountIQD;
  final String code;
  final DateTime timestamp;
  final Color brandColor;
  final String region;
  final String category;

  const OrderItem({
    required this.id,
    required this.cardTitle,
    required this.cardSubtitle,
    required this.usdValue,
    required this.paidAmountIQD,
    required this.code,
    required this.timestamp,
    required this.brandColor,
    this.region = 'أمريكي 🇺🇸',
    required this.category,
  });

  String get formattedDate {
    return '${timestamp.year}/${timestamp.month.toString().padLeft(2, '0')}/${timestamp.day.toString().padLeft(2, '0')} ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }
}
