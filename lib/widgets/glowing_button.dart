import 'package:flutter/material.dart';
import '../core/colors.dart';

class GlowingButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Widget? icon;
  final bool isLoading;
  final Color backgroundColor;
  final Color textColor;
  final double height;
  final double? width;
  final bool showArrow;

  const GlowingButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.backgroundColor = AppColors.neonLime,
    this.textColor = AppColors.textDark,
    this.height = 54,
    this.width,
    this.showArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: onPressed != null && backgroundColor == AppColors.neonLime
            ? [
                BoxShadow(
                  color: AppColors.neonLime.withOpacity(0.38),
                  blurRadius: 18,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          disabledBackgroundColor: backgroundColor.withOpacity(0.4),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: textColor,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    icon!,
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  if (showArrow) ...[
                    const SizedBox(width: 6),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                      color: textColor,
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}
