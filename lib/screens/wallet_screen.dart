import 'package:flutter/material.dart';
import '../providers/app_state.dart';
import '../widgets/glowing_button.dart';

class WalletScreen extends StatelessWidget {
  final AppState appState;

  const WalletScreen({super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'المحفظة الإلكترونية',
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // كارت الرصيد الملكي (أسود أوبسيديان فاخر)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0F172A).withOpacity(0.22),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'الرصيد المتاح حالياً',
                          style: TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 13,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E293B),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'نشط ومؤمّن 🔒',
                            style: TextStyle(
                              color: Color(0xFFE2E8F0),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      AppState.formatIQD(appState.walletBalance),
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) =>
                              WalletRechargeSheet(appState: appState),
                        );
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_circle_outline_rounded,
                              size: 18,
                              color: Color(0xFF0F172A),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'شحن رصيد إضافي',
                              style: TextStyle(
                                color: Color(0xFF0F172A),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
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

              const SizedBox(height: 28),

              // طرق التعبئة المعتمدة في العراق
              const Text(
                'طرق التعبئة المعتمدة في العراق',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                  fontFamily: 'Cairo',
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  _buildPaymentBadge(
                      'زين كاش', 'ZainCash', const Color(0xFF831843)),
                  const SizedBox(width: 8),
                  _buildPaymentBadge(
                      'كي كارد', 'Qi Card', const Color(0xFF0369A1)),
                  const SizedBox(width: 8),
                  _buildPaymentBadge(
                      'فاست بي', 'FastPay', const Color(0xFFD97706)),
                  const SizedBox(width: 8),
                  _buildPaymentBadge(
                      'مصرف FIB', 'FIB Bank', const Color(0xFF0F766E)),
                ],
              ),

              const SizedBox(height: 28),

              // سجل الحركات المالية
              const Text(
                'سجل الحركات المالية',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                  fontFamily: 'Cairo',
                ),
              ),
              const SizedBox(height: 12),

              if (appState.orders.isEmpty)
                Container(
                  padding: const EdgeInsets.all(24),
                  alignment: Alignment.center,
                  child: const Text(
                    'لا توجد عمليات سابقة',
                    style: TextStyle(
                        color: Color(0xFF94A3B8), fontFamily: 'Cairo'),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: appState.orders.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final order = appState.orders[index];
                    return Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
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
                              color: const Color(0xFFEF4444).withOpacity(0.12),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_upward_rounded,
                              color: Color(0xFFEF4444),
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.cardTitle,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Color(0xFF0F172A),
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  order.formattedDate,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF94A3B8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '- ${AppState.formatIQD(order.paidAmountIQD)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xFFEF4444),
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

              const SizedBox(height: 95),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentBadge(String nameAr, String nameEn, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.25)),
        ),
        child: Column(
          children: [
            Text(
              nameAr,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: color,
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 2),
            Text(
              nameEn,
              style: TextStyle(
                fontSize: 9,
                color: color.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WalletRechargeSheet extends StatefulWidget {
  final AppState appState;

  const WalletRechargeSheet({super.key, required this.appState});

  @override
  State<WalletRechargeSheet> createState() => _WalletRechargeSheetState();
}

class _WalletRechargeSheetState extends State<WalletRechargeSheet> {
  int _selectedAmount = 25000;
  String _selectedMethod = 'زين كاش';
  bool _isProcessing = false;

  final List<int> _amounts = [10000, 25000, 50000, 100000];

  void _recharge() async {
    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;
    widget.appState.rechargeWallet(_selectedAmount);

    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'تمت تعبئة ${AppState.formatIQD(_selectedAmount)} بنجاح عبر $_selectedMethod',
          style: const TextStyle(fontFamily: 'Cairo'),
        ),
        backgroundColor: const Color(0xFF0F172A),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'شحن رصيد المحفظة',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'اختر المبلغ المطلوب شحنه بالدينار:',
              style: TextStyle(
                  fontSize: 12, color: Color(0xFF64748B), fontFamily: 'Cairo'),
            ),
            const SizedBox(height: 10),
            Row(
              children: _amounts.map((amount) {
                final isSelected = _selectedAmount == amount;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: InkWell(
                      onTap: () => setState(() => _selectedAmount = amount),
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF0F172A)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF0F172A)
                                : const Color(0xFFE2E8F0),
                          ),
                        ),
                        child: Text(
                          AppState.formatIQD(amount).replaceAll(' د.ع', ''),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 18),
            const Text(
              'طريقة الدفع:',
              style: TextStyle(
                  fontSize: 12, color: Color(0xFF64748B), fontFamily: 'Cairo'),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children:
                  ['زين كاش', 'كي كارد', 'فاست بي', 'FIB Bank'].map((method) {
                final isSelected = _selectedMethod == method;
                return ChoiceChip(
                  label: Text(method),
                  selected: isSelected,
                  selectedColor: const Color(0xFF0F172A),
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF64748B),
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    fontFamily: 'Cairo',
                  ),
                  onSelected: (_) => setState(() => _selectedMethod = method),
                );
              }).toList(),
            ),
            const SizedBox(height: 22),
            GlowingButton(
              text: 'تأكيد الشحن الآن',
              backgroundColor: const Color(0xFF0F172A),
              textColor: Colors.white,
              isLoading: _isProcessing,
              onPressed: _recharge,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
