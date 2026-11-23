import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _orbitController;
  late AnimationController _progressController;

  late Animation<double> _pulseAnimation;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    // 1. نبضة الشعار في المنتصف
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    _pulseAnimation = Tween<double>(begin: 0.96, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _pulseController.repeat(reverse: true);

    // 2. دوران النقاط في المدار الدائري
    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    // 3. شريط التحميل الانسيابي المتدرج (يتحرك بوضوح ونعومة فائقة من 0% إلى 100%)
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    );

    _progressAnimation = CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOutCubic,
    );

    _progressController.forward();

    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToOnboarding();
      }
    });
  }

  void _navigateToOnboarding() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => const OnboardingScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity:
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            child: child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _orbitController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F1D),
      body: GestureDetector(
        onTap: _navigateToOnboarding,
        behavior: HitTestBehavior.opaque,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // تدرج الخلفية بألوان الكحلي والنيلي الملكي الفاخر
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(0, -0.2),
                    radius: 1.0,
                    colors: [
                      Color(0xFF1E3A8A),
                      Color(0xFF0F172A),
                      Color(0xFF0A0F1D),
                    ],
                    stops: [0.0, 0.55, 1.0],
                  ),
                ),
              ),
            ),

            // MADE FOR PLAY — العراق
            Positioned(
              top: 50,
              child: SafeArea(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'MADE FOR PLAY',
                      style: TextStyle(
                        fontSize: 11,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        width: 14,
                        height: 1.5,
                        color: const Color(0xFF38BDF8),
                      ),
                    ),
                    Text(
                      'العراق',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.85),
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // المنتصف: الشعار والمدارات الفضائية
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // هالة التوهج الأزرق الملكي الفخمة
                      Container(
                        width: 260,
                        height: 260,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF2563EB).withOpacity(0.35),
                              blurRadius: 90,
                              spreadRadius: 20,
                            ),
                          ],
                        ),
                      ),

                      // المدار الخارجي
                      Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF38BDF8).withOpacity(0.25),
                            width: 1.2,
                          ),
                        ),
                      ),

                      // المدار الداخلي
                      Container(
                        width: 195,
                        height: 195,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF60A5FA).withOpacity(0.2),
                            width: 1.0,
                          ),
                        ),
                      ),

                      // النقاط المتحركة في المدار
                      AnimatedBuilder(
                        animation: _orbitController,
                        builder: (context, child) {
                          final angle = _orbitController.value * 2 * math.pi;
                          return SizedBox(
                            width: 250,
                            height: 250,
                            child: Stack(
                              children: [
                                // النقطة السماوية المتوهجة
                                Positioned(
                                  left: 125 + 125 * math.cos(angle) - 4.5,
                                  top: 125 + 125 * math.sin(angle) - 4.5,
                                  child: Container(
                                    width: 9,
                                    height: 9,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xFF38BDF8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF38BDF8)
                                              .withOpacity(0.9),
                                          blurRadius: 12,
                                          spreadRadius: 2.5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // النقطة النيلية المضيئة
                                Positioned(
                                  left: 125 +
                                      98 * math.cos(angle + math.pi * 0.8) -
                                      4,
                                  top: 125 +
                                      98 * math.sin(angle + math.pi * 0.8) -
                                      4,
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xFF60A5FA),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF60A5FA)
                                              .withOpacity(0.9),
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      // المربع المتدرج النابض بالأزرق الملكي
                      AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _pulseAnimation.value,
                            child: Container(
                              width: 105,
                              height: 105,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF1E3A8A),
                                    Color(0xFF2563EB),
                                    Color(0xFF3B82F6),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(34),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF2563EB)
                                        .withOpacity(0.5),
                                    blurRadius: 35,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: CustomPaint(
                                  size: const Size(64, 44),
                                  painter: HeartbeatLinePainter(
                                    color: Colors.white,
                                    strokeWidth: 4.8,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 38),
                  const Text(
                    'نبض',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 2.0,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'N  A  B  D',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF93C5FD),
                      letterSpacing: 6.0,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'كل اللعب، بنبض واحد.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.7),
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),

            // شريط التحميل السفلي المتحرك بوضوح وأناقة فائقة
            Positioned(
              bottom: 45,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // النقطة اليسرى المضيئة
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF38BDF8),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF38BDF8).withOpacity(0.8),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),

                      // مسار شريط التحميل (عريض 150px ويتحرك بوضوح كبير)
                      Container(
                        width: 150,
                        height: 6,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E293B),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: const Color(0xFF334155),
                            width: 1,
                          ),
                        ),
                        child: AnimatedBuilder(
                          animation: _progressAnimation,
                          builder: (context, child) {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 150 * _progressAnimation.value,
                                height: 6,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF38BDF8),
                                      Color(0xFF2563EB),
                                      Color(0xFF60A5FA),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF38BDF8)
                                          .withOpacity(0.85),
                                      blurRadius: 10,
                                      spreadRadius: 1.5,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 10),

                      // النقطة اليمنى المضيئة
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF60A5FA),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF60A5FA).withOpacity(0.8),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'بطاقاتك الرقمية، أقرب من أي وقت',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(0.55),
                      letterSpacing: 0.2,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    width: 120,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(2),
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
}

class HeartbeatLinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  HeartbeatLinePainter({required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final glowPaint = Paint()
      ..color = color.withOpacity(0.35)
      ..strokeWidth = strokeWidth * 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    final path = Path();
    path.moveTo(0, size.height * 0.52);
    path.lineTo(size.width * 0.22, size.height * 0.52);
    path.lineTo(size.width * 0.32, size.height * 0.76);
    path.lineTo(size.width * 0.48, size.height * 0.12);
    path.lineTo(size.width * 0.66, size.height * 0.88);
    path.lineTo(size.width * 0.78, size.height * 0.52);
    path.lineTo(size.width, size.height * 0.52);

    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
