import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../models/gift_card.dart';
import '../providers/app_state.dart';
import '../widgets/custom_card_widget.dart';
import '../widgets/glowing_button.dart';
import 'purchase_modal.dart';

class CardDetailScreen extends StatefulWidget {
  final GiftCardItem card;
  final AppState appState;

  const CardDetailScreen({
    super.key,
    required this.card,
    required this.appState,
  });

  @override
  State<CardDetailScreen> createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<CardDetailScreen> {
  late DenominationOption _selectedDenomination;
  bool _termsAccepted = true;

  @override
  void initState() {
    super.initState();
    // Default to 2nd denomination if available (e.g. $25)
    _selectedDenomination = widget.card.denominations.length > 1
        ? widget.card.denominations[1]
        : widget.card.denominations.first;
  }

  void _openPurchaseModal() {
    if (!_termsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'يرجى تأكيد موافقتك على شروط مطابقة منطقة الحساب للمتابعة',
            style: TextStyle(fontFamily: 'Cairo'),
          ),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => PurchaseModal(
        card: widget.card,
        selectedDenomination: _selectedDenomination,
        appState: widget.appState,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('تفاصيل البطاقة'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.headset_mic_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('الدعم الفني متاح عبر واتساب وتليغرام 24/7'),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 1. Hero Card Graphic matching Screen 6
                    CustomCardWidget(
                      card: widget.card,
                      selectedUsdValue: _selectedDenomination.usdValue,
                      height: 195,
                    ),

                    const SizedBox(height: 18),

                    // 2. Badges: "الأكثر مبيعاً" & "تسليم فوري"
                    Row(
                      children: [
                        if (widget.card.isBestSeller) ...[
                          _buildBadge(
                            text: 'الأكثر مبيعاً',
                            backgroundColor:
                                AppColors.neonViolet.withOpacity(0.18),
                            borderColor: AppColors.neonViolet.withOpacity(0.5),
                            textColor: const Color(0xFFD8B4FE),
                            icon: Icons.local_fire_department_rounded,
                          ),
                          const SizedBox(width: 8),
                        ],
                        if (widget.card.hasInstantDelivery)
                          _buildBadge(
                            text: 'تسليم فوري',
                            backgroundColor:
                                AppColors.neonLime.withOpacity(0.15),
                            borderColor: AppColors.neonLime.withOpacity(0.4),
                            textColor: AppColors.neonLime,
                            icon: Icons.bolt_rounded,
                          ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // 3. Card Title & Subtitle
                    Text(
                      widget.card.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${widget.card.brand} Store - \$${_selectedDenomination.usdValue} USD',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 4. Specs Grid (المنطقة, الصلاحية, نوع التسليم)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.surfaceBorder),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildSpecItem(
                            label: 'المنطقة',
                            value: widget.card.region,
                          ),
                          Container(
                            height: 30,
                            width: 1,
                            color: AppColors.surfaceBorder,
                          ),
                          _buildSpecItem(
                            label: 'الصلاحية',
                            value: widget.card.validity,
                          ),
                          Container(
                            height: 30,
                            width: 1,
                            color: AppColors.surfaceBorder,
                          ),
                          _buildSpecItem(
                            label: 'نوع التسليم',
                            value: widget.card.deliveryType,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 5. Denomination selection: "اختر قيمة البطاقة"
                    const Text(
                      'اختر قيمة البطاقة',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: widget.card.denominations.map((denom) {
                        final isSelected = denom == _selectedDenomination;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedDenomination = denom;
                                });
                              },
                              borderRadius: BorderRadius.circular(14),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.neonViolet.withOpacity(0.2)
                                      : AppColors.surface,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.neonViolet
                                        : AppColors.surfaceBorder,
                                    width: isSelected ? 2 : 1,
                                  ),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: AppColors.neonViolet
                                                .withOpacity(0.3),
                                            blurRadius: 10,
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      widget.card.category == 'شحن مباشر'
                                          ? '${denom.usdValue} UC'
                                          : '\$${denom.usdValue}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                        color: isSelected
                                            ? Colors.white
                                            : AppColors.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      AppState.formatIQD(denom.iqdPrice),
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected
                                            ? AppColors.neonLime
                                            : AppColors.textMuted,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),

                    // 6. Info Description Box
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.surfaceBorder),
                      ),
                      child: Text(
                        widget.card.description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          height: 1.6,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // 7. Terms & region agreement checkbox
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _termsAccepted = !_termsAccepted;
                        });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 2),
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _termsAccepted
                                  ? AppColors.neonLime
                                  : Colors.transparent,
                              border: Border.all(
                                color: _termsAccepted
                                    ? AppColors.neonLime
                                    : AppColors.textMuted,
                                width: 1.8,
                              ),
                            ),
                            child: _termsAccepted
                                ? const Icon(
                                    Icons.check,
                                    size: 14,
                                    color: AppColors.textDark,
                                  )
                                : null,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              widget.card.termsWarning,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.textMuted,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Bottom Sticky Bar matching Screen 6
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: const Border(
                  top: BorderSide(color: AppColors.surfaceBorder, width: 1),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Total Price display
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'السعر الإجمالي',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        AppState.formatIQD(_selectedDenomination.iqdPrice),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),

                  // Big Neon Lime Button: "شراء من المحفظة"
                  Expanded(
                    child: GlowingButton(
                      text: 'شراء من المحفظة',
                      icon: const Icon(Icons.account_balance_wallet_rounded,
                          size: 18, color: AppColors.textDark),
                      onPressed: _openPurchaseModal,
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

  Widget _buildBadge({
    required String text,
    required Color backgroundColor,
    required Color borderColor,
    required Color textColor,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: textColor),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecItem({
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.textMuted,
          ),
        ),
        const SizedBox(height: 4),
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
