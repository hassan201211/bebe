import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/colors.dart';
import '../providers/app_state.dart';

class OrdersScreen extends StatelessWidget {
  final AppState appState;

  const OrdersScreen({super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    final orders = appState.orders;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'طلباتي وبطاقاتي',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: orders.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.receipt_long_outlined,
                      size: 64,
                      color: const Color(0xFF94A3B8).withOpacity(0.5),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'لا توجد طلبات حتى الآن',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF0F172A),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'قم بشراء بطاقتك الأولى لتظهر أكوادك هنا فوراً',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.only(
                    left: 18, right: 18, top: 12, bottom: 95),
                itemCount: orders.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                          color: const Color(0xFFE2E8F0), width: 1.2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // الصف العلوي: اسم البطاقة والحالة
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: order.brandColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  order.cardTitle,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0F172A),
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 9, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'تم التسليم ⚡',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF334155),
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        Text(
                          order.cardSubtitle,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF64748B),
                            fontFamily: 'Cairo',
                          ),
                        ),

                        const SizedBox(height: 14),

                        // صندوق الكود الأسود الأوبسيديان الملكي عالي الوضوح
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0F172A),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xFF0F172A).withOpacity(0.12),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                order.code,
                                style: const TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2.0,
                                  color: Colors.white,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Clipboard.setData(
                                      ClipboardData(text: order.code));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'تم نسخ الكود: ${order.code}',
                                        style: const TextStyle(
                                            fontFamily: 'Cairo'),
                                      ),
                                      backgroundColor: const Color(0xFF0F172A),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1E293B),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.copy_rounded,
                                          size: 14, color: Colors.white),
                                      SizedBox(width: 4),
                                      Text(
                                        'نسخ',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: 'Cairo',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // الصف السفلي: السعر وتاريخ الشراء
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              order.formattedDate,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF94A3B8),
                              ),
                            ),
                            Text(
                              AppState.formatIQD(order.paidAmountIQD),
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F172A),
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
