import 'package:flutter/material.dart';
import '../core/colors.dart';

class NabdLogo extends StatelessWidget {
  final double size;
  final bool showBadge;
  final bool showText;
  final bool withGlow;

  const NabdLogo({
    super.key,
    this.size = 80,
    this.showBadge = true,
    this.showText = false,
    this.withGlow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Outer glow effect
            if (withGlow)
              Container(
                width: size * 1.35,
                height: size * 1.35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.neonLime.withOpacity(0.22),
                      blurRadius: 40,
                      spreadRadius: 8,
                    ),
                    BoxShadow(
                      color: AppColors.neonViolet.withOpacity(0.18),
                      blurRadius: 50,
                      spreadRadius: 10,
                    ),
                  ],
                ),
              ),

            // Subtle neon orbital ring
            if (withGlow)
              Container(
                width: size * 1.25,
                height: size * 1.25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.neonLime.withOpacity(0.12),
                    width: 1.5,
                  ),
                ),
              ),

            // Squircle container
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF17202F),
                    Color(0xFF0F1522),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(size * 0.32),
                border: Border.all(
                  color: AppColors.neonLime.withOpacity(0.7),
                  width: 2.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.neonLime.withOpacity(0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: CustomPaint(
                  size: Size(size * 0.62, size * 0.42),
                  painter: HeartbeatPainter(
                    color: AppColors.neonLime,
                    strokeWidth: size * 0.065,
                  ),
                ),
              ),
            ),
          ],
        ),
        if (showText) ...[
          const SizedBox(height: 18),
          const Text(
            'نبض',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'N A B D',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
              letterSpacing: 5.0,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'كل اللعب، بنبض واحد.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ],
    );
  }
}

class HeartbeatPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  HeartbeatPainter({
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final glowPaint = Paint()
      ..color = color.withOpacity(0.4)
      ..strokeWidth = strokeWidth * 2.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    final path = Path();
    // Starting horizontal line
    path.moveTo(0, size.height * 0.52);
    path.lineTo(size.width * 0.22, size.height * 0.52);
    // Pulse dip down
    path.lineTo(size.width * 0.32, size.height * 0.76);
    // High spike up
    path.lineTo(size.width * 0.48, size.height * 0.12);
    // Sharp dip down
    path.lineTo(size.width * 0.66, size.height * 0.88);
    // Return to baseline
    path.lineTo(size.width * 0.78, size.height * 0.52);
    // Ending line
    path.lineTo(size.width, size.height * 0.52);

    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
