import 'package:flutter/material.dart';
import '../models/gift_card.dart';

class DenominationCardTile extends StatelessWidget {
  final DenominationOption denomination;
  final BrandStoreItem brand;
  final VoidCallback onTap;

  const DenominationCardTile({
    super.key,
    required this.denomination,
    required this.brand,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // الجزء العلوي: بطاقة الشحن التفاعلية المصممة بالضبط كما في صورتك
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
                child: _buildCardGraphic(),
              ),
            ),

            // الجزء السفلي: شريط أبيض نقي باسم الكود/الفئة والسعر
            Container(
              padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(15)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    denomination.displayCode,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    _formatIQD(denomination.iqdPrice),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF10B981), // أخضر راقي للسعر
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // رسم وتصميم البطاقات حسب ما هو موجود بصورة المتجر تماماً
  // رسم وتصميم البطاقات (يدعم الصور الحقيقية + الرسم البديل)
  Widget _buildCardGraphic() {
    // 1. إذا كان الكارت يمتلك صورة محلية
    if (denomination.imageAsset != null &&
        denomination.imageAsset!.isNotEmpty) {
      return Image.asset(
        denomination.imageAsset!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildFallbackGraphic(),
      );
    }

    // 2. إذا كان الكارت يمتلك رابط صورة من لوحة التحكم أو الإنترنت
    if (denomination.imageUrl != null && denomination.imageUrl!.isNotEmpty) {
      return Image.network(
        denomination.imageUrl!,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: const Color(0xFFF1F5F9),
            child: const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color(0xFF2563EB),
                ),
              ),
            ),
          );
        },
        errorBuilder: (_, __, ___) => _buildFallbackGraphic(),
      );
    }

    // 3. الرسم المتجهي البديل
    return _buildFallbackGraphic();
  }

  Widget _buildFallbackGraphic() {
    switch (denomination.graphicType) {
      case 'red_network':
        // كارت 70,000 آسياسيل (أحمر + شبكة + 4G+)
        return Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [Color(0xFFE5252D), Color(0xFF990D13), Color(0xFF6B0409)],
              center: Alignment.center,
              radius: 1.1,
            ),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'تعبئة رصيد اتصال\nآسياسيل',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Cairo',
                      height: 1.1,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Asiacell',
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFD61F26),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      denomination.displayTitle.contains('70,000')
                          ? '70,000'
                          : '25,000',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const Text(
                      'IQD',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '+4G إنترنت سريع',
                    style: TextStyle(
                        fontSize: 7.5,
                        color: Colors.white70,
                        fontFamily: 'Cairo'),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const Text(
                      'تغطية واسعة',
                      style: TextStyle(
                          fontSize: 7,
                          color: Colors.white,
                          fontFamily: 'Cairo'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );

      case 'max_card':
        // كارت MAX CARD 12,000 (أحمر مع تفاصيل الدقائق والجيجات)
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFDC2626), Color(0xFFB91C1C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF7F1D1D),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Column(
                      children: [
                        Text('12,000',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold)),
                        Text('دينار',
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 7,
                                fontFamily: 'Cairo')),
                      ],
                    ),
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('MAX',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w900)),
                      Text('CARD',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  _buildMaxStatBox('5GB', 'إنترنت'),
                  const SizedBox(width: 3),
                  _buildMaxStatBox('180', 'دقيقة'),
                  const SizedBox(width: 3),
                  _buildMaxStatBox('50', 'رسائل'),
                ],
              ),
            ],
          ),
        );

      case 'martyr_monument':
        // كارت 50,000 دينار مع رسمة نصب الشهيد وغروب الشمس
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF9D174D),
                Color(0xFFBE185D),
                Color(0xFFF43F5E),
                Color(0xFFFDE047)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(8),
          child: Stack(
            children: [
              Positioned(
                top: 6,
                right: 32,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFEF08A),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: const Text('Asiacell',
                      style: TextStyle(
                          color: Color(0xFFD61F26),
                          fontSize: 7,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 28,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: Color(0xFFCBD5E1),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: 28,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: Color(0xFF94A3B8),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF9F1239),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('دينار',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 6,
                              fontFamily: 'Cairo')),
                      Text('50,000',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w900)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );

      default:
        // كارت عام راقي بلون العلامة التجارية
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [brand.themeColor, brand.themeColor.withOpacity(0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    brand.englishName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(Icons.wifi_tethering,
                      color: Colors.white70, size: 14),
                ],
              ),
              Center(
                child: Text(
                  denomination.displayTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatIQD(denomination.iqdPrice),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  const Text(
                    'تسليم فوري ⚡',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 8,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
    }
  }

  Widget _buildMaxStatBox(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            Text(value,
                style: const TextStyle(
                    color: Color(0xFF991B1B),
                    fontSize: 9,
                    fontWeight: FontWeight.w900)),
            Text(label,
                style: const TextStyle(
                    color: Color(0xFF991B1B),
                    fontSize: 7,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo')),
          ],
        ),
      ),
    );
  }

  static String _formatIQD(int amount) {
    final str = amount.toString();
    final buffer = StringBuffer();
    int count = 0;
    for (int i = str.length - 1; i >= 0; i--) {
      buffer.write(str[i]);
      count++;
      if (count % 3 == 0 && i != 0) {
        buffer.write(',');
      }
    }
    return '${buffer.toString().split('').reversed.join()} د.ع';
  }
}
