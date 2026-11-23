import 'package:flutter/material.dart';
import 'auth_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingData> _pages = [
    const OnboardingData(
      innerTag: 'كودك جاهز خلال ثوانٍ ⚡',
      badgeIcon: Icons.bolt_rounded,
      badgeText: 'لا وقت للانتظار',
      badgeBg: Color(0xFFEFF6FF),
      badgeFg: Color(0xFF2563EB),
      title: 'ادفع. استلم. العب.',
      subtitle:
          'بطاقتك وكودك بلمح البصر، اشحن لعبتك\nالمفضلة وخلي الحماس مستمر.',
      btnText: 'التالي',
      type: IllustrationType.lightning,
    ),
    const OnboardingData(
      innerTag: 'سعر واضح، بدون مفاجآت 🏷️',
      badgeIcon: Icons.local_offer_outlined,
      badgeText: 'قيمة أكثر لكل شحنة',
      badgeBg: Color(0xFFFEF3C7),
      badgeFg: Color(0xFFD97706),
      title: 'العب أكثر. ادفع أقل.',
      subtitle:
          'أسعار تنافسية بالدينار العراقي، وعروض\nتخلّي رصيدك يوصلك أبعد.',
      btnText: 'التالي',
      type: IllustrationType.discount,
    ),
    const OnboardingData(
      innerTag: 'أنت المتحكّم بكل عملية 🛡️',
      badgeIcon: Icons.shield_outlined,
      badgeText: 'راحة بالك أولاً',
      badgeBg: Color(0xFFECFDF5),
      badgeFg: Color(0xFF059669),
      title: 'محفظتك بأمان.',
      subtitle:
          'ادفع بثقة من رصيد محفظتك، كل عملية\nبتأكيد واضح، وكل بطاقة محفوظة إلك.',
      btnText: 'يلا نبدأ',
      type: IllustrationType.shield,
    ),
  ];

  void _onNext() {
    if (_currentIndex < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _goToAuth();
    }
  }

  void _goToAuth() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) => const AuthScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Stack(
        children: [
          // إضاءة علوية ناعمة
          Positioned(
            top: -100,
            left: 0,
            right: 0,
            child: Container(
              height: 380,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.0, -0.2),
                  radius: 0.9,
                  colors: [
                    const Color(0xFF2563EB).withOpacity(0.08),
                    const Color(0xFF38BDF8).withOpacity(0.04),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // الشريط العلوي: تخطي + الشعار
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: _goToAuth,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFE2E8F0),
                              width: 1,
                            ),
                          ),
                          child: const Text(
                            'تخطي',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF64748B),
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'NABD',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2.0,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF2563EB), Color(0xFF4F46E5)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFF2563EB).withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: CustomPaint(
                                size: const Size(16, 12),
                                painter: MiniPulsePainter(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // محتوى الشرائح
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _pages.length,
                    onPageChanged: (index) {
                      setState(() => _currentIndex = index);
                    },
                    itemBuilder: (context, index) {
                      final item = _pages[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 270,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(32),
                                border: Border.all(
                                  color: const Color(0xFFE2E8F0),
                                  width: 1.2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF0F172A)
                                        .withOpacity(0.06),
                                    blurRadius: 24,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Center(
                                    child: _buildIllustration(item.type),
                                  ),
                                  Positioned(
                                    bottom: 14,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF8FAFC),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: const Color(0xFFE2E8F0),
                                          width: 1,
                                        ),
                                      ),
                                      child: Text(
                                        item.innerTag,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF475569),
                                          fontFamily: 'Cairo',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                color: item.badgeBg,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    item.badgeIcon,
                                    size: 14,
                                    color: item.badgeFg,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    item.badgeText,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: item.badgeFg,
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              item.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF0F172A),
                                fontFamily: 'Cairo',
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item.subtitle,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF64748B),
                                height: 1.5,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // الجزء السفلي: المؤشرات والزر الأزرق الملكي
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_pages.length, (index) {
                          final isActive = index == _currentIndex;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 6,
                            width: isActive ? 26 : 6,
                            decoration: BoxDecoration(
                              gradient: isActive
                                  ? const LinearGradient(
                                      colors: [
                                        Color(0xFF2563EB),
                                        Color(0xFF4F46E5),
                                      ],
                                    )
                                  : null,
                              color: isActive ? null : const Color(0xFFCBD5E1),
                              borderRadius: BorderRadius.circular(3),
                              boxShadow: isActive
                                  ? [
                                      BoxShadow(
                                        color: const Color(0xFF2563EB)
                                            .withOpacity(0.4),
                                        blurRadius: 8,
                                        spreadRadius: 1,
                                      ),
                                    ]
                                  : null,
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 20),

                      // زر التالي المتدرج بالأزرق الملكي
                      Container(
                        width: double.infinity,
                        height: 54,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF2563EB),
                              Color(0xFF4F46E5),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF2563EB).withOpacity(0.35),
                              blurRadius: 18,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: _onNext,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _pages[_currentIndex].btnText,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.arrow_back_rounded,
                                size: 18,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      GestureDetector(
                        onTap: _goToAuth,
                        child: RichText(
                          text: const TextSpan(
                            text: 'عندك حساب بالفعل؟ ',
                            style: TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 13,
                              fontFamily: 'Cairo',
                            ),
                            children: [
                              TextSpan(
                                text: 'تسجيل الدخول',
                                style: TextStyle(
                                  color: Color(0xFF2563EB),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIllustration(IllustrationType type) {
    switch (type) {
      case IllustrationType.lightning:
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF38BDF8).withOpacity(0.25),
                    blurRadius: 60,
                    spreadRadius: 10,
                  ),
                ],
              ),
            ),
            Transform.rotate(
              angle: -0.22,
              child: Container(
                width: 115,
                height: 155,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                  ),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFF38BDF8).withOpacity(0.4),
                    width: 1.5,
                  ),
                ),
              ),
            ),
            Transform.rotate(
              angle: 0.16,
              child: Container(
                width: 125,
                height: 165,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
                  ),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2563EB).withOpacity(0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 22,
                        height: 16,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFCD34D),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 50,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 55,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFF59E0B).withOpacity(0.4),
                      blurRadius: 30,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.bolt_rounded,
                  size: 84,
                  color: Color(0xFFF59E0B),
                ),
              ),
            ),
          ],
        );

      case IllustrationType.discount:
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2563EB).withOpacity(0.2),
                    blurRadius: 60,
                    spreadRadius: 10,
                  ),
                ],
              ),
            ),
            for (int i = 0; i < 3; i++)
              Positioned(
                top: 45.0 + (i * 18.0),
                child: Container(
                  width: 145.0 - (i * 12.0),
                  height: 95.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF2563EB).withOpacity(0.9 - (i * 0.15)),
                        Color(0xFF1D4ED8).withOpacity(0.9 - (i * 0.15)),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.4),
                      width: 1.2,
                    ),
                  ),
                ),
              ),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF2563EB), Color(0xFF4F46E5)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2563EB).withOpacity(0.5),
                    blurRadius: 25,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.percent_rounded,
                size: 50,
                color: Colors.white,
              ),
            ),
          ],
        );

      case IllustrationType.shield:
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF059669).withOpacity(0.2),
                    blurRadius: 60,
                    spreadRadius: 10,
                  ),
                ],
              ),
            ),
            Container(
              width: 135,
              height: 155,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                  bottomLeft: Radius.circular(68),
                  bottomRight: Radius.circular(68),
                ),
                border: Border.all(
                  color: const Color(0xFF10B981),
                  width: 2.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF10B981).withOpacity(0.3),
                    blurRadius: 25,
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF10B981).withOpacity(0.15),
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    size: 60,
                    color: Color(0xFF10B981),
                  ),
                ),
              ),
            ),
          ],
        );
    }
  }
}

enum IllustrationType { lightning, discount, shield }

class OnboardingData {
  final String innerTag;
  final IconData badgeIcon;
  final String badgeText;
  final Color badgeBg;
  final Color badgeFg;
  final String title;
  final String subtitle;
  final String btnText;
  final IllustrationType type;

  const OnboardingData({
    required this.innerTag,
    required this.badgeIcon,
    required this.badgeText,
    required this.badgeBg,
    required this.badgeFg,
    required this.title,
    required this.subtitle,
    required this.btnText,
    required this.type,
  });
}

class MiniPulsePainter extends CustomPainter {
  final Color color;

  MiniPulsePainter({this.color = Colors.white});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.5);
    path.lineTo(size.width * 0.3, size.height * 0.5);
    path.lineTo(size.width * 0.45, size.height * 0.1);
    path.lineTo(size.width * 0.65, size.height * 0.9);
    path.lineTo(size.width * 0.78, size.height * 0.5);
    path.lineTo(size.width, size.height * 0.5);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
