import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/colors.dart';
import '../models/order.dart';
import '../providers/app_state.dart';
import '../widgets/glowing_button.dart';
import 'main_navigation_screen.dart';

class SuccessScreen extends StatefulWidget {
  final OrderItem order;
  final AppState appState;

  const SuccessScreen({
    super.key,
    required this.order,
    required this.appState,
  });

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  bool _isCopied = false;

  void _copyCode() {
    Clipboard.setData(ClipboardData(text: widget.order.code));
    setState(() => _isCopied = true);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: AppColors.neonLime),
            const SizedBox(width: 8),
            Text(
              'تم نسخ الكود بنجاح: ${widget.order.code}',
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.surface,
        duration: const Duration(seconds: 2),
      ),
    );

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => _isCopied = false);
    });
  }

  void _goToHome() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const MainNavigationScreen(initialTabIndex: 0),
      ),
      (route) => false,
    );
  }

  void _goToOrders() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) =>
            const MainNavigationScreen(initialTabIndex: 2), // orders tab
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('استلام البطاقة'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, size: 20),
          onPressed: _goToHome,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.headset_mic_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),

              // Glowing Green Check Circle
              Center(
                child: Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.neonLime.withOpacity(0.18),
                    border: Border.all(
                      color: AppColors.neonLime,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.neonLime.withOpacity(0.35),
                        blurRadius: 28,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check_rounded,
                      color: AppColors.neonLime,
                      size: 44,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Title
              const Text(
                'مبروك، بطاقتك جاهزة!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'تم إتمام عملية الدفع بنجاح، كودك متاح أدناه:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 24),

              // Card Item Summary Bar
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.surfaceBorder),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 32,
                      decoration: BoxDecoration(
                        color: widget.order.brandColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Center(
                        child: Icon(Icons.sports_esports_rounded,
                            size: 18, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.order.cardSubtitle,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            '${widget.order.region} • تسليم فوري',
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Voucher Code Container matching Screen 8
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF131B2A),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.neonLime.withOpacity(0.5),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.neonLime.withOpacity(0.15),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'كود بطاقتك',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.neonLime.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.bolt_rounded,
                                  size: 12, color: AppColors.neonLime),
                              SizedBox(width: 2),
                              Text(
                                'تم التسليم',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.neonLime,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Prominent Code
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.neonLime.withOpacity(0.3),
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          widget.order.code,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 3.5,
                            color: AppColors.neonLime,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Copy Code Button
                    InkWell(
                      onTap: _copyCode,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _isCopied
                              ? AppColors.neonLime
                              : AppColors.surfaceLight,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.neonLime.withOpacity(0.4),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _isCopied
                                  ? Icons.check_rounded
                                  : Icons.copy_rounded,
                              size: 16,
                              color: _isCopied
                                  ? AppColors.textDark
                                  : AppColors.neonLime,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _isCopied ? 'تم نسخ الكود!' : 'نسخ الكود',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: _isCopied
                                    ? AppColors.textDark
                                    : AppColors.neonLime,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'انسخ الكود وفعله في متجر البلايستيشن أو المتجر المعتمد مباشرة.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.textMuted,
                ),
              ),

              const SizedBox(height: 20),

              // Transaction details
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.surfaceBorder),
                ),
                child: Column(
                  children: [
                    _buildReceiptRow(
                      'المبلغ المدفوع',
                      AppState.formatIQD(widget.order.paidAmountIQD),
                    ),
                    const SizedBox(height: 8),
                    _buildReceiptRow(
                      'الرصيد المتبقي',
                      AppState.formatIQD(widget.appState.walletBalance),
                    ),
                    const SizedBox(height: 8),
                    _buildReceiptRow('رقم العملية', widget.order.id),
                    const SizedBox(height: 8),
                    _buildReceiptRow('وقت العملية', widget.order.formattedDate),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Return to Home Button
              GlowingButton(
                text: 'العودة للرئيسية',
                icon: const Icon(Icons.home_rounded,
                    size: 18, color: AppColors.textDark),
                onPressed: _goToHome,
              ),

              const SizedBox(height: 12),

              // View My Orders Button
              OutlinedButton(
                onPressed: _goToOrders,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  side: const BorderSide(color: AppColors.surfaceBorder),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.receipt_long_rounded, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'عرض طلباتي',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
