import 'package:flutter/material.dart';
import '../providers/app_state.dart';
import 'auth_screen.dart';

class ProfileScreen extends StatelessWidget {
  final AppState appState;

  const ProfileScreen({super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'الإعدادات والحساب',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Color(0xFF0F172A),
            fontFamily: 'Cairo',
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // كارت المستخدم الأسود الفاخر المطعم بالأبيض
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0F172A).withOpacity(0.18),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // رصيد المحفظة
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'رصيد المحفظة',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF94A3B8),
                            fontFamily: 'Cairo',
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          AppState.formatIQD(appState.walletBalance),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // بيانات المستخدم
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E293B),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'موثّق',
                                style: TextStyle(
                                  color: Color(0xFF38BDF8),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              appState.userName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          appState.userPhone,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF94A3B8),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(width: 14),

                    // الصورة الشخصية
                    Container(
                      padding: const EdgeInsets.all(2.5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF334155),
                          width: 1.8,
                        ),
                      ),
                      child: const CircleAvatar(
                        radius: 26,
                        backgroundColor: Color(0xFF1E293B),
                        child: Icon(
                          Icons.person_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // قسم: إعدادات الأمان
              _buildSectionTitle('الأمان والحساب'),
              const SizedBox(height: 10),
              _buildWhiteGroup([
                _buildTile(
                  icon: Icons.lock_outline_rounded,
                  title: 'تغيير كلمة المرور',
                  subtitle: 'عبر مراسلة الوكيل المعتمد',
                  iconColor: const Color(0xFF0F172A),
                ),
                _buildDivider(),
                _buildTile(
                  icon: Icons.fingerprint_rounded,
                  title: 'تسجيل الدخول بالبصمة / FaceID',
                  subtitle: 'مفعّل للحماية السريعة',
                  iconColor: const Color(0xFF6366F1),
                ),
                _buildDivider(),
                _buildTile(
                  icon: Icons.notifications_none_rounded,
                  title: 'إشعارات الأكواد الفورية',
                  subtitle: 'تنبيه مباشر عند وصول الكود',
                  iconColor: const Color(0xFF0284C7),
                ),
              ]),

              const SizedBox(height: 22),

              // قسم: الوكلاء المعتمدون والدعم
              _buildSectionTitle('الوكلاء المعتمدون والدعم الفني'),
              const SizedBox(height: 10),
              _buildWhiteGroup([
                _buildTile(
                  icon: Icons.chat_rounded,
                  title: 'محادثة الوكيل عبر واتساب',
                  subtitle: '+964 770 123 4567 • متصل الآن',
                  iconColor: const Color(0xFF22C55E),
                ),
                _buildDivider(),
                _buildTile(
                  icon: Icons.send_rounded,
                  title: 'قناة وكلاء نبض على تليغرام',
                  subtitle: '@Nabd_Agent_Support',
                  iconColor: const Color(0xFF0284C7),
                ),
                _buildDivider(),
                _buildTile(
                  icon: Icons.info_outline_rounded,
                  title: 'عن تطبيق نبض',
                  subtitle: 'الإصدار 1.0 (صنع في العراق 🇮🇶)',
                  iconColor: const Color(0xFFF59E0B),
                ),
              ]),

              const SizedBox(height: 26),

              // زر تسجيل الخروج
              InkWell(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const AuthScreen()),
                    (route) => false,
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFEF4444).withOpacity(0.4),
                      width: 1.2,
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout_rounded,
                          size: 18, color: Color(0xFFEF4444)),
                      SizedBox(width: 8),
                      Text(
                        'تسجيل الخروج من الحساب',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEF4444),
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 95),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Color(0xFF64748B),
          fontFamily: 'Cairo',
        ),
      ),
    );
  }

  Widget _buildWhiteGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(color: Color(0xFFF1F5F9), height: 1),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailingWidget,
    required Color iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          trailingWidget ??
              const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 13,
                color: Color(0xFF94A3B8),
              ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
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
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF64748B),
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(width: 14),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
        ],
      ),
    );
  }
}
