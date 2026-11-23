import 'package:flutter/material.dart';
import '../providers/app_state.dart';
import '../widgets/brand_card_tile.dart';
import 'denominations_screen.dart';
import 'wallet_screen.dart';

class HomeScreen extends StatelessWidget {
  final AppState appState;
  final Function(int)? onNavigateTab;

  const HomeScreen({
    super.key,
    required this.appState,
    this.onNavigateTab,
  });

  @override
  Widget build(BuildContext context) {
    final brands = appState.filteredBrands;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: RefreshIndicator(
          color: const Color(0xFF0F172A),
          backgroundColor: Colors.white,
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 400));
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              // 1. شريط الرأس مع الترحيب
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 14, 18, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.notifications_none_rounded,
                          color: Color(0xFF0F172A),
                          size: 22,
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'هلا بيك، ${appState.userName} 👋',
                                style: const TextStyle(
                                  color: Color(0xFF64748B),
                                  fontSize: 12,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                              const Text(
                                'متجر البطاقات الرقمية',
                                style: TextStyle(
                                  color: Color(0xFF0F172A),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 42,
                            height: 42,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF0F172A),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.bolt_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // 2. كارت المحفظة
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  child: _buildWalletCard(context),
                ),
              ),

              // 3. شريط البحث
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  child: _buildSearchBar(),
                ),
              ),

              // 4. التصنيفات
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: _buildCategoryTabs(),
                ),
              ),

              // 5. العنوان
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 14, 18, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${brands.length} خدمات متوفرة',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const Text(
                        'اختر بطاقتك لتصفح كل الفئات',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0F172A),
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 6. شبكة البطاقات
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(18, 4, 18, 100),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.84,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final brand = brands[index];
                      return BrandCardTile(
                        brand: brand,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DenominationsScreen(
                                brand: brand,
                                appState: appState,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    childCount: brands.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWalletCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withOpacity(0.18),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF38BDF8),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'متاح للاستخدام',
                    style: TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 12,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  Text(
                    'رصيد المحفظة',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(
                    Icons.account_balance_wallet_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  if (onNavigateTab != null) {
                    onNavigateTab!(1);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => WalletScreen(appState: appState),
                      ),
                    );
                  }
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF334155)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.add, color: Colors.white, size: 14),
                      SizedBox(width: 4),
                      Text(
                        'شحن الرصيد',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                AppState.formatIQD(appState.walletBalance),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        textAlign: TextAlign.right,
        onChanged: (val) => appState.setSearchQuery(val),
        decoration: InputDecoration(
          hintText: 'ابحث عن بطاقتك المفضلة...',
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 13,
            fontFamily: 'Cairo',
          ),
          prefixIcon:
              const Icon(Icons.search_rounded, color: Color(0xFF64748B)),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    final categories = [
      'الكل',
      'اتصالات عراقية',
      'ألعاب وشحن',
      'متاجر وبطاقات'
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      reverse: true,
      child: Row(
        children: categories.map((cat) {
          final isSelected = appState.selectedCategory == cat;
          return Padding(
            padding: const EdgeInsets.only(left: 8),
            child: InkWell(
              onTap: () => appState.setCategory(cat),
              borderRadius: BorderRadius.circular(14),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF0F172A) : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF0F172A)
                        : const Color(0xFFE2E8F0),
                    width: 1.2,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(0xFF0F172A).withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  cat,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                    color: isSelected ? Colors.white : const Color(0xFF64748B),
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
