import 'package:flutter/material.dart';
import '../models/gift_card.dart';

class BrandCardTile extends StatelessWidget {
  final BrandStoreItem brand;
  final VoidCallback onTap;

  const BrandCardTile({
    super.key,
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
            // الجزء العلوي: الصورة والشعار الفاخر للعلامة التجارية
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
                child: _buildBrandBanner(brand.bannerType),
              ),
            ),

            // الجزء السفلي: شريط أبيض نقي باسم البطاقة
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(15)),
              ),
              child: Text(
                brand.englishName,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandBanner(String type) {
    // 1. إذا كان يمتلك صورة لوجو محلية
    if (brand.imageAsset != null && brand.imageAsset!.isNotEmpty) {
      return Container(
        color: Colors.white,
        padding: const EdgeInsets.all(12),
        child: Image.asset(
          brand.imageAsset!,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => _buildFallbackBanner(type),
        ),
      );
    }

    // 2. إذا كان يمتلك رابط صورة من لوحة التحكم أو الإنترنت
    if (brand.imageUrl != null && brand.imageUrl!.isNotEmpty) {
      return Container(
        color: Colors.white,
        padding: const EdgeInsets.all(12),
        child: Image.network(
          brand.imageUrl!,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              color: const Color(0xFFF8FAFC),
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
          errorBuilder: (_, __, ___) => _buildFallbackBanner(type),
        ),
      );
    }

    // 3. الرسم المتجهي البديل
    return _buildFallbackBanner(type);
  }

  Widget _buildFallbackBanner(String type) {
    switch (type) {
      case 'zain':
        return Container(
          color: Colors.white,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                  size: const Size(120, 100), painter: _ZainSwirlPainter()),
              Positioned(
                bottom: 8,
                child: Text(
                  'Zain',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    color: const Color(0xFF5A1E52).withOpacity(0.85),
                  ),
                ),
              ),
            ],
          ),
        );

      case 'asiacell':
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE0F2FE), Color(0xFFBAE6FD)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                  size: const Size(110, 60), painter: _AsiacellLogoPainter()),
            ],
          ),
        );

      case 'iraqcell':
        return Container(
          color: Colors.white,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.language_rounded, color: Color(0xFFFBBF24), size: 38),
              SizedBox(height: 4),
              Text(
                'IRAQ CELL',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E3A8A),
                  letterSpacing: 0.8,
                ),
              ),
              Text(
                'عراق سيل',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E3A8A),
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
        );

      case 'korek':
        return Container(
          color: const Color(0xFF0070BA),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wifi_tethering_rounded,
                    color: Colors.white, size: 28),
                SizedBox(width: 8),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'KOREK',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      'Telecom',
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );

      case 'pubg':
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1E1B4B), Color(0xFF312E81)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'PUBG',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  'MOBILE',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF59E0B),
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        );

      case 'alkafeel':
        return Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'الكفيل',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFDC2626),
                        fontFamily: 'Cairo',
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'أمنية',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1E3A8A),
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
                Text(
                  'مستقبل الاتصالات في العراق',
                  style: TextStyle(
                      fontSize: 8,
                      color: Colors.grey.shade600,
                      fontFamily: 'Cairo'),
                ),
              ],
            ),
          ),
        );

      case 'xbox':
        return Container(
          color: const Color(0xFF107C10),
          child: const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.sports_esports, color: Colors.white, size: 24),
                SizedBox(height: 6),
                Icon(Icons.shopping_bag_outlined,
                    color: Colors.white, size: 32),
              ],
            ),
          ),
        );

      case 'razer':
        return Container(
          color: const Color(0xFF0A0A0A),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF59E0B),
                  ),
                  child: const Center(
                    child: Text('Z',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Colors.black)),
                  ),
                ),
                const SizedBox(width: 8),
                const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('RAZER',
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00FF00))),
                    Text('Global',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
        );

      case 'playstation':
        return Container(
          color: const Color(0xFF003791),
          child: const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.gamepad_rounded, color: Colors.white, size: 30),
                SizedBox(height: 4),
                Text('PlayStation',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: Colors.white)),
              ],
            ),
          ),
        );

      case 'steam':
        return Container(
          color: const Color(0xFF171A21),
          child: const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.stream_rounded, color: Colors.white, size: 30),
                SizedBox(height: 4),
                Text('STEAM',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        color: Colors.white)),
              ],
            ),
          ),
        );

      default:
        return Container(
          color: Colors.white,
          child: const Center(
            child:
                Icon(Icons.apple_rounded, color: Color(0xFF1E293B), size: 38),
          ),
        );
    }
  }
}

class _ZainSwirlPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD1D5DB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5;

    final center = Offset(size.width * 0.45, size.height * 0.45);
    for (int i = 1; i <= 3; i++) {
      canvas.drawCircle(center, i * 11.0, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _AsiacellLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD61F26)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width * 0.2, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.1,
        size.width * 0.8, size.height * 0.35);
    path.quadraticBezierTo(size.width * 0.6, size.height * 0.6,
        size.width * 0.2, size.height * 0.4);
    canvas.drawPath(path, paint);

    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'Asiacell',
        style: TextStyle(
          color: Color(0xFFD61F26),
          fontSize: 18,
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.italic,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(canvas,
        Offset((size.width - textPainter.width) / 2, size.height * 0.45));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
