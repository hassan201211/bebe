import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/gift_card.dart';
import '../providers/app_state.dart';
import '../widgets/custom_card_widget.dart';
import 'card_detail_screen.dart';
import 'purchase_modal.dart';
import 'success_screen.dart';

class CategoryProductsScreen extends StatefulWidget {
  final AppSection section;
  final AppState appState;

  const CategoryProductsScreen({
    super.key,
    required this.section,
    required this.appState,
  });

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  void _openPurchase(GiftCardItem card, DenominationOption denomination) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => PurchaseModal(
        card: card,
        selectedDenomination: denomination,
        appState: widget.appState,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final section = widget.section;

    // تجميع كافة الفئات المتوفرة في هذا القسم
    final List<Map<String, dynamic>> allTiers = [];
    for (final card in section.cards) {
      for (final denom in card.denominations) {
        allTiers.add({
          'card': card,
          'denom': denom,
        });
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFF07080D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0D15),
        elevation: 0,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'قسم ${section.name}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                fontFamily: 'Cairo',
              ),
            ),
            Text(
              '${section.englishName} • ${allTiers.length} فئات متاحة',
              style: TextStyle(
                fontSize: 11,
                color: Colors.white.withOpacity(0.55),
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward_ios_rounded,
              color: Colors.white, size: 18),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF131522),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF22273A)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.account_balance_wallet_rounded,
                    color: Color(0xFFA3FF12), size: 15),
                const SizedBox(width: 6),
                Text(
                  AppState.formatIQD(widget.appState.walletBalance),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: section.primaryColor.withOpacity(0.18),
                boxShadow: [
                  BoxShadow(
                    color: section.primaryColor.withOpacity(0.2),
                    blurRadius: 100,
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: [
                // بانر القسم الفاخر
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    gradient: LinearGradient(
                      colors: [
                        section.primaryColor.withOpacity(0.9),
                        section.accentColor.withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(color: Colors.white.withOpacity(0.15)),
                    boxShadow: [
                      BoxShadow(
                        color: section.primaryColor.withOpacity(0.35),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.35),
                          borderRadius: BorderRadius.circular(16),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.15)),
                        ),
                        child:
                            Icon(section.icon, color: Colors.white, size: 36),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFA3FF12).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'تسليم فوري ⚡ • كود أصلي 100%',
                                style: TextStyle(
                                  color: Color(0xFFA3FF12),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              section.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                fontFamily: 'Cairo',
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              section.description,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white.withOpacity(0.85),
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'اختر الفئة والسعر المطلوب',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.5),
                        fontFamily: 'Cairo',
                      ),
                    ),
                    const Text(
                      'الفئات والأسعار المتوفرة',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // شبكة صور وفئات وأسعار البطاقات
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.63,
                  ),
                  itemCount: allTiers.length,
                  itemBuilder: (context, index) {
                    final item = allTiers[index];
                    final card = item['card'] as GiftCardItem;
                    final denom = item['denom'] as DenominationOption;

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => CardDetailScreen(
                              card: card,
                              appState: widget.appState,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF131522),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: const Color(0xFF22273A)),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // صورة البطاقة بدون أي Overflow
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CustomCardWidget(
                                card: card,
                                selectedUsdValue: denom.usdValue,
                                height: 86,
                                isMini: true,
                              ),
                            ),

                            const SizedBox(height: 8),

                            // اسم الفئة
                            Text(
                              denom.label,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                fontFamily: 'Cairo',
                              ),
                            ),
                            Text(
                              card.titleEn,
                              textAlign: TextAlign.right,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white.withOpacity(0.45),
                                fontFamily: 'Cairo',
                              ),
                            ),

                            const Spacer(),

                            // السعر بالدينار العراقي
                            Text(
                              AppState.formatIQD(denom.iqdPrice),
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFFA3FF12),
                                fontFamily: 'Cairo',
                              ),
                            ),

                            const SizedBox(height: 8),

                            // زر الشراء الفوري
                            InkWell(
                              onTap: () => _openPurchase(card, denom),
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFFA3FF12).withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color(0xFFA3FF12)
                                        .withOpacity(0.4),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.bolt_rounded,
                                      size: 14,
                                      color: Color(0xFFA3FF12),
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'شراء فوري',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFA3FF12),
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
                    );
                  },
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
