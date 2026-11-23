import 'package:flutter/material.dart';
import '../models/gift_card.dart';
import '../providers/app_state.dart';
import '../widgets/denomination_card_tile.dart';
import 'purchase_modal.dart';

class DenominationsScreen extends StatelessWidget {
  final BrandStoreItem brand;
  final AppState appState;

  const DenominationsScreen({
    super.key,
    required this.brand,
    required this.appState,
  });

  void _openPurchase(BuildContext context, DenominationOption denomination) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => PurchaseModal(
        card: brand.toGiftCardItem(),
        selectedDenomination: denomination,
        appState: appState,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF0F172A), size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          brand.englishName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Color(0xFF0F172A),
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.account_balance_wallet_rounded,
                    color: Color(0xFF10B981), size: 14),
                const SizedBox(width: 4),
                Text(
                  AppState.formatIQD(appState.walletBalance),
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.82,
                  ),
                  itemCount: brand.denominations.length,
                  itemBuilder: (context, index) {
                    final denom = brand.denominations[index];
                    return DenominationCardTile(
                      denomination: denom,
                      brand: brand,
                      onTap: () => _openPurchase(context, denom),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
