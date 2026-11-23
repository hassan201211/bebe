import 'dart:ui';
import 'package:flutter/material.dart';
import '../widgets/nabd_logo.dart';
import 'main_navigation_screen.dart';

class AuthScreen extends StatefulWidget {
  final bool initialIsLogin;

  const AuthScreen({
    super.key,
    this.initialIsLogin = true,
  });

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // 1. نافذة تسجيل الدخول عبر الإيميل والباسورد
  void _openEmailLoginSheet() {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    bool obscurePassword = true;
    bool isLoading = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Container(
                          width: 44,
                          height: 4,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE2E8F0),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      const Text(
                        'تسجيل الدخول',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0F172A),
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'أدخل البريد الإلكتروني وكلمة المرور المسجلة لديك',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 24),

                      // حقل البريد الإلكتروني
                      const Text(
                        'البريد الإلكتروني',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              color: const Color(0xFFE2E8F0), width: 1.2),
                        ),
                        child: TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                          decoration: const InputDecoration(
                            hintText: 'example@domain.com',
                            hintStyle: TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 13,
                            ),
                            prefixIcon: Icon(
                              Icons.alternate_email_rounded,
                              color: Color(0xFF2563EB),
                              size: 20,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // حقل كلمة المرور
                      const Text(
                        'كلمة المرور',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              color: const Color(0xFFE2E8F0), width: 1.2),
                        ),
                        child: TextField(
                          controller: passwordController,
                          obscureText: obscurePassword,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                          decoration: InputDecoration(
                            hintText: '••••••••',
                            hintStyle: const TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 14,
                            ),
                            prefixIcon: const Icon(
                              Icons.lock_outline_rounded,
                              color: Color(0xFF2563EB),
                              size: 20,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: const Color(0xFF64748B),
                                size: 20,
                              ),
                              onPressed: () {
                                setModalState(() {
                                  obscurePassword = !obscurePassword;
                                });
                              },
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _openAgentContactSheet();
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'نسيت كلمة المرور؟ راسل الوكيل',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF2563EB),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // زر تسجيل الدخول بتدرج أزرق ملكي فاخر
                      InkWell(
                        onTap: isLoading
                            ? null
                            : () {
                                setModalState(() => isLoading = true);
                                Future.delayed(
                                    const Duration(milliseconds: 650), () {
                                  Navigator.pop(context);
                                  _enterApp();
                                });
                              },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF2563EB), Color(0xFF4F46E5)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xFF2563EB).withOpacity(0.35),
                                blurRadius: 16,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Center(
                            child: isLoading
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'تسجيل الدخول',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // 2. نافذة الوكلاء الرسمية (واتساب وتليغرام)
  void _openAgentContactSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 44,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'تواصل مع وكيل نبض المعتمد 🇮🇶',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                    fontFamily: 'Cairo',
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'إنشاء وتفعيل الحسابات وشحن الرصيد يتم حصراً عن طريق الوكلاء المعتمدين لضمان أمان حسابك ومحفظتك.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                    fontFamily: 'Cairo',
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                _buildAgentTile(
                  icon: Icons.chat_rounded,
                  title: 'مراسلة عبر واتساب (WhatsApp)',
                  subtitle: '+964 770 123 4567 • متصل الآن 🟢',
                  iconColor: const Color(0xFF16A34A),
                  badgeColor: const Color(0xFFDCFCE7),
                  onTap: () {
                    Navigator.pop(context);
                    _enterApp();
                  },
                ),
                const SizedBox(height: 14),
                _buildAgentTile(
                  icon: Icons.send_rounded,
                  title: 'مراسلة عبر تليغرام (Telegram)',
                  subtitle: '@Nabd_Agent_IQ • رد سريع ⚡',
                  iconColor: const Color(0xFF0284C7),
                  badgeColor: const Color(0xFFE0F2FE),
                  onTap: () {
                    Navigator.pop(context);
                    _enterApp();
                  },
                ),
                const SizedBox(height: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _enterApp() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => const MainNavigationScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  Widget _buildAgentTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    required Color badgeColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                      fontFamily: 'Cairo',
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF64748B),
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 13,
              color: Color(0xFF94A3B8),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Stack(
        children: [
          // إضاءة علوية لطيفة وسماوية ناعمة
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
                // الشعار العلوي NABD بألوان التطبيق المعتمدة
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'NABD',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2.5,
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
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF2563EB).withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.bolt_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // المنتصف: النبض الأزرق الملكي الفاخر والمدارات الناعمة
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // المدار الخارجي الناعم 1
                            Container(
                              width: 220,
                              height: 220,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color:
                                      const Color(0xFFCBD5E1).withOpacity(0.6),
                                  width: 1.2,
                                ),
                              ),
                            ),
                            // المدار الداخلي 2
                            Container(
                              width: 170,
                              height: 170,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFFBAE6FD),
                                  width: 1.2,
                                ),
                              ),
                            ),
                            // النقطة المدارية المضيئة بالأزرق السماوي
                            Positioned(
                              right: 32,
                              top: 42,
                              child: Container(
                                width: 9,
                                height: 9,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0284C7),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF38BDF8)
                                          .withOpacity(0.7),
                                      blurRadius: 8,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // مربع الشعار بتدرج أزرق ملكي ونيلي فاخر
                            Container(
                              width: 88,
                              height: 88,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF1E3A8A),
                                    Color(0xFF2563EB),
                                    Color(0xFF4F46E5),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(26),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF2563EB)
                                        .withOpacity(0.38),
                                    blurRadius: 24,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: CustomPaint(
                                  size: const Size(48, 28),
                                  painter: HeartbeatPainter(
                                    color: Colors.white,
                                    strokeWidth: 3.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'هلا بيك في نبض',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0F172A),
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'كل اللعب، بنبض واحد.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2563EB),
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'اختار طريقتك حتى تبدأ.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF94A3B8),
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ),

                // الجزء السفلي
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'عندك حساب بالفعل؟',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF64748B),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // زر تسجيل الدخول بتدرج أزرق ملكي رائع
                      InkWell(
                        onTap: _openEmailLoginSheet,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          height: 54,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF2563EB), Color(0xFF4F46E5)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xFF2563EB).withOpacity(0.35),
                                blurRadius: 16,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.white,
                                size: 14,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'تسجيل الدخول',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // فاصل "أو" هادئ
                      const Row(
                        children: [
                          Expanded(
                              child:
                                  Divider(color: Color(0xFFE2E8F0), height: 1)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            child: Text(
                              'أو',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF94A3B8),
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ),
                          Expanded(
                              child:
                                  Divider(color: Color(0xFFE2E8F0), height: 1)),
                        ],
                      ),

                      const SizedBox(height: 18),

                      // بطاقة "جديد على نبض؟" بتصميم أبيض نظيف وأنيق
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: const Color(0xFFE2E8F0),
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF0F172A).withOpacity(0.04),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'جديد على نبض؟',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF0F172A),
                                fontFamily: 'Cairo',
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'راسل الوكيل حتى يساعدك بإنشاء حسابك، وتبدأ رحلتك ويانا!',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF64748B),
                                height: 1.4,
                                fontFamily: 'Cairo',
                              ),
                            ),
                            const SizedBox(height: 14),
                            InkWell(
                              onTap: _openAgentContactSheet,
                              borderRadius: BorderRadius.circular(14),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEFF6FF),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: const Color(0xFFBFDBFE),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'مراسلة وكيل',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF2563EB),
                                        fontFamily: 'Cairo',
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(
                                      Icons.chat_bubble_outline_rounded,
                                      color: Color(0xFF2563EB),
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
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
}
