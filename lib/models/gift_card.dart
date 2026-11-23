import 'package:flutter/material.dart';

class DenominationOption {
  final int usdValue;
  final int iqdPrice;
  final String? customLabel;
  final String? code;
  final String? title;
  final String? badge;
  final String graphicType;
  final String? imageUrl;
  final String? imageAsset;

  const DenominationOption({
    required this.usdValue,
    required this.iqdPrice,
    this.customLabel,
    this.code,
    this.title,
    this.badge,
    this.graphicType = 'standard',
    this.imageUrl,
    this.imageAsset,
  });

  String get label => customLabel ?? code ?? '\$$usdValue';
  String get displayTitle => title ?? label;
  String get displayCode => code ?? label;
  bool get hasImage =>
      (imageUrl != null && imageUrl!.isNotEmpty) ||
      (imageAsset != null && imageAsset!.isNotEmpty);
}

class GiftCardItem {
  final String id;
  final String title;
  final String titleEn;
  final String subtitle;
  final String brand;
  final Color primaryColor;
  final Color accentColor;
  final String category;
  final String region;
  final String validity;
  final String deliveryType;
  final String description;
  final String termsWarning;
  final bool isBestSeller;
  final bool hasInstantDelivery;
  final List<DenominationOption> denominations;
  final String? imageUrl;
  final String? logoUrl;
  final String? imageAsset;
  final String? logoAsset;

  const GiftCardItem({
    required this.id,
    required this.title,
    required this.titleEn,
    required this.subtitle,
    required this.brand,
    required this.primaryColor,
    required this.accentColor,
    required this.category,
    this.region = 'العراق 🇮🇶',
    this.validity = 'بدون انتهاء ⏳',
    this.deliveryType = 'كود رقمي ⚡',
    required this.description,
    required this.termsWarning,
    this.isBestSeller = false,
    this.hasInstantDelivery = true,
    required this.denominations,
    this.imageUrl,
    this.logoUrl,
    this.imageAsset,
    this.logoAsset,
  });

  int get defaultPrice =>
      denominations.isNotEmpty ? denominations[0].iqdPrice : 0;
  int get defaultUsd =>
      denominations.isNotEmpty ? denominations[0].usdValue : 0;
  bool get hasImage =>
      (imageUrl != null && imageUrl!.isNotEmpty) ||
      (imageAsset != null && imageAsset!.isNotEmpty);
}

class AppSection {
  final String id;
  final String name;
  final String englishName;
  final IconData icon;
  final Color primaryColor;
  final Color accentColor;
  final String badgeText;
  final String description;
  final List<GiftCardItem> cards;

  const AppSection({
    required this.id,
    required this.name,
    required this.englishName,
    required this.icon,
    required this.primaryColor,
    required this.accentColor,
    required this.badgeText,
    required this.description,
    required this.cards,
  });
}

class BrandStoreItem {
  final String id;
  final String name;
  final String englishName;
  final String category;
  final Color themeColor;
  final List<DenominationOption> denominations;
  final String bannerType;
  final String? imageUrl;
  final String? logoUrl;
  final String? imageAsset;
  final String? logoAsset;

  const BrandStoreItem({
    required this.id,
    required this.name,
    required this.englishName,
    required this.category,
    required this.themeColor,
    required this.denominations,
    required this.bannerType,
    this.imageUrl,
    this.logoUrl,
    this.imageAsset,
    this.logoAsset,
  });

  bool get hasImage =>
      (imageUrl != null && imageUrl!.isNotEmpty) ||
      (imageAsset != null && imageAsset!.isNotEmpty);
  bool get hasLogo =>
      (logoUrl != null && logoUrl!.isNotEmpty) ||
      (logoAsset != null && logoAsset!.isNotEmpty);

  GiftCardItem toGiftCardItem() {
    return GiftCardItem(
      id: id,
      title: name,
      titleEn: englishName,
      subtitle: '$englishName Official Cards',
      brand: englishName,
      primaryColor: themeColor,
      accentColor: themeColor.withOpacity(0.8),
      category: category,
      description: 'بطاقات وكروت شحن $name الرسمية مع تسليم فوري للأكواد.',
      termsWarning: 'تأكد من استرداد الكود على الحساب المتوافق.',
      denominations: denominations,
      imageUrl: imageUrl,
      logoUrl: logoUrl,
      imageAsset: imageAsset,
      logoAsset: logoAsset,
    );
  }
}
