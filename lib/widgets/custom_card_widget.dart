import 'package:flutter/material.dart';
import '../models/gift_card.dart';

class CustomCardWidget extends StatelessWidget {
  final GiftCardItem card;
  final int? selectedUsdValue;
  final double height;
  final double? width;
  final bool isMini;

  const CustomCardWidget({
    super.key,
    required this.card,
    this.selectedUsdValue,
    this.height = 180,
    this.width,
    this.isMini = false,
  });

  @override
  Widget build(BuildContext context) {
    final displayUsd = selectedUsdValue ?? card.defaultUsd;

    return Container(
      height: isMini ? 88 : height,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isMini ? 12 : 20),
        gradient: LinearGradient(
          colors: [
            card.primaryColor,
            card.accentColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: card.primaryColor.withOpacity(0.35),
            blurRadius: isMini ? 8 : 20,
            offset: Offset(0, isMini ? 3 : 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isMini ? 12 : 20),
        child: Stack(
          children: [
            // صورة خلفية الكارت إذا كانت متوفرة
            if (card.imageAsset != null && card.imageAsset!.isNotEmpty)
              Positioned.fill(
                child: Opacity(
                  opacity: 0.22,
                  child: Image.asset(
                    card.imageAsset!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const SizedBox(),
                  ),
                ),
              ),
            if (card.imageUrl != null && card.imageUrl!.isNotEmpty)
              Positioned.fill(
                child: Opacity(
                  opacity: 0.22,
                  child: Image.network(
                    card.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const SizedBox(),
                  ),
                ),
              ),
            Positioned(
              right: -30,
              top: -30,
              child: Container(
                width: isMini ? 70 : 160,
                height: isMini ? 70 : 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.08),
                ),
              ),
            ),
            Positioned(
              right: isMini ? 20 : 40,
              bottom: -40,
              child: Container(
                width: isMini ? 90 : 200,
                height: isMini ? 90 : 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.15),
                ),
              ),
            ),

            // محتوى الكارت المحمي من أي Overflow
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMini ? 8 : 20,
                vertical: isMini ? 6 : 16,
              ),
              child: isMini
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // الصف العلوي
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    _getBrandIcon(card.brand),
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                  const SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      card.brand,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.contactless_rounded,
                              color: Colors.white.withOpacity(0.7),
                              size: 13,
                            ),
                          ],
                        ),

                        // القيمة
                        Text(
                          card.category == 'شحن مباشر' ||
                                  card.category == 'ببجي موبايل'
                              ? '$displayUsd UC'
                              : card.category == 'رصيد محلي'
                                  ? '$displayUsd د.ع'
                                  : '\$$displayUsd',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                          ),
                        ),

                        // الصف السفلي
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                card.titleEn,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 1.5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.35),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                card.region.contains('العراق') ? 'IQ' : 'US',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 7.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  _getBrandIcon(card.brand),
                                  color: Colors.white,
                                  size: 22,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  card.brand,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.contactless_rounded,
                              color: Colors.white.withOpacity(0.7),
                              size: 24,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              card.category == 'شحن مباشر' ||
                                      card.category == 'ببجي موبايل'
                                  ? '$displayUsd UC'
                                  : card.category == 'رصيد محلي'
                                      ? '$displayUsd د.ع'
                                      : '\$$displayUsd',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'DIGITAL GIFT CARD',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.75),
                                fontSize: 10,
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                card.titleEn,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                card.region.contains('العراق')
                                    ? 'العراق 🇮🇶'
                                    : 'أمريكي 🇺🇸',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getBrandIcon(String brand) {
    switch (brand.toLowerCase()) {
      case 'playstation':
        return Icons.sports_esports_rounded;
      case 'xbox':
        return Icons.videogame_asset_rounded;
      case 'steam':
        return Icons.gamepad_rounded;
      case 'pubg mobile':
        return Icons.military_tech_rounded;
      case 'apple':
      case 'itunes':
        return Icons.apple_rounded;
      case 'google play':
        return Icons.play_arrow_rounded;
      default:
        return Icons.credit_card_rounded;
    }
  }
}
