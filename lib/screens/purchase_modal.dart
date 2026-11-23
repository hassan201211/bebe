import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../models/gift_card.dart';
import '../providers/app_state.dart';
import '../widgets/custom_card_widget.dart';
import '../widgets/glowing_button.dart';
import 'success_screen.dart';
import 'wallet_screen.dart';

class PurchaseModal extends StatefulWidget {
  final GiftCardItem card;
  final DenominationOption selectedDenomination;
  final AppState appState;

  const PurchaseModal({
    super.key,
    required this.card,
    required this.selectedDenomination,
    required this.appState,
  });

  @override
  State<PurchaseModal> createState() => _PurchaseModalState();
}

class _PurchaseModalState extends State<PurchaseModal> {
  bool _isProcessing = false;

  void _confirmAndPay() async {
    final price = widget.selectedDenomination.iqdPrice;

    if (!widget.appState.canAfford(price)) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => WalletRechargeSheet(appState: widget.appState),
      );
      return;
    }

    setState(() => _isProcessing = true);

    await Future.delayed(const Duration(milliseconds: 1000));

    if (!mounted) return;

    final order = widget.appState.executePurchase(
      card: widget.card,
      denomination: widget.selectedDenomination,
    );

    if (order != null) {
      Navigator.pop(context); // close modal

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => SuccessScreen(
            order: order,
            appState: widget.appState,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentBalance = widget.appState.walletBalance;
    final cardPrice = widget.selectedDenomination.iqdPrice;
    final remainingBalance = currentBalance - cardPrice;
    final hasEnoughBalance = currentBalance >= cardPrice;

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF111726),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        border: Border(
          top: BorderSide(color: AppColors.surfaceBorder, width: 1.5),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.surfaceBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Header Title
            const Text(
              'تأكيد الشراء',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'مرجع الطلب: #NABD-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textMuted,
              ),
            ),

            const SizedBox(height: 20),

            // Mini Product Summary Container
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.surfaceBorder),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CustomCardWidget(
                      card: widget.card,
                      selectedUsdValue: widget.selectedDenomination.usdValue,
                      height: 52,
                      width: 80,
                      isMini: true,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.card.brand} Store - \$${widget.selectedDenomination.usdValue} USD',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${widget.card.region} • ${widget.card.deliveryType}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Financial Breakdown List matching Screen 7
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.surfaceBorder),
              ),
              child: Column(
                children: [
                  _buildCostRow(
                    label: 'رصيد محفظتك الحالي',
                    value: AppState.formatIQD(currentBalance),
                    valueColor: AppColors.textPrimary,
                  ),
                  const SizedBox(height: 12),
                  _buildCostRow(
                    label: 'قيمة البطاقة',
                    value: AppState.formatIQD(cardPrice),
                    valueColor: AppColors.textPrimary,
                  ),
                  const SizedBox(height: 12),
                  _buildCostRow(
                    label: 'الرسوم',
                    value: 'مجاناً',
                    valueColor: AppColors.success,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(color: AppColors.surfaceBorder, height: 1),
                  ),
                  _buildCostRow(
                    label: 'الرصيد بعد الشراء',
                    value: AppState.formatIQD(
                        remainingBalance > 0 ? remainingBalance : 0),
                    isBold: true,
                    valueColor: hasEnoughBalance
                        ? AppColors.neonLime
                        : AppColors.error,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Security note
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_outline_rounded,
                  size: 14,
                  color: AppColors.textMuted.withOpacity(0.8),
                ),
                const SizedBox(width: 6),
                Text(
                  hasEnoughBalance
                      ? 'سيتم خصم المبلغ من رصيد محفظتك فوراً'
                      : 'رصيدك غير كافٍ لإتمام عملية الشراء',
                  style: TextStyle(
                    fontSize: 11,
                    color: hasEnoughBalance
                        ? AppColors.textSecondary
                        : AppColors.error,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // CTA Button: "تأكيد ودفع 37,500 د.ع"
            GlowingButton(
              text: hasEnoughBalance
                  ? 'تأكيد ودفع ${AppState.formatIQD(cardPrice)}'
                  : 'شحن رصيد المحفظة الآن',
              isLoading: _isProcessing,
              backgroundColor: hasEnoughBalance
                  ? AppColors.neonLime
                  : AppColors.neonViolet,
              textColor: hasEnoughBalance
                  ? AppColors.textDark
                  : Colors.white,
              onPressed: _confirmAndPay,
            ),

            const SizedBox(height: 12),

            // Cancel button
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.textSecondary,
                ),
                child: const Text(
                  'تراجع / إلغاء',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCostRow({
    required String label,
    required String value,
    Color? valueColor,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? 14 : 13,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isBold ? AppColors.textPrimary : AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 16 : 13,
            fontWeight: isBold ? FontWeight.w900 : FontWeight.bold,
            color: valueColor ?? AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
