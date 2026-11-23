import 'dart:ui';
import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 18, right: 18, bottom: 20),
      height: 68,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 25,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            spreadRadius: -2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.94),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: const Color(0xFFE2E8F0),
                width: 1.2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(
                  index: 3,
                  icon: Icons.person_outline_rounded,
                  activeIcon: Icons.person_rounded,
                  label: 'حسابي',
                ),
                _buildNavItem(
                  index: 2,
                  icon: Icons.receipt_long_outlined,
                  activeIcon: Icons.receipt_long_rounded,
                  label: 'طلباتي',
                ),
                _buildNavItem(
                  index: 1,
                  icon: Icons.account_balance_wallet_outlined,
                  activeIcon: Icons.account_balance_wallet_rounded,
                  label: 'المحفظة',
                ),
                _buildNavItem(
                  index: 0,
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home_rounded,
                  label: 'الرئيسية',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16 : 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0F172A) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF0F172A).withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected) ...[
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
              const SizedBox(width: 6),
            ],
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? Colors.white : const Color(0xFF64748B),
              size: isSelected ? 22 : 24,
            ),
          ],
        ),
      ),
    );
  }
}
